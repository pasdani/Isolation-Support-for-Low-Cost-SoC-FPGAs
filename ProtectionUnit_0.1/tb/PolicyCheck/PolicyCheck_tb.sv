`timescale 1 ns / 1 ps

module PolicyCheck_tb ();
  
  
localparam int unsigned NUM_MEM_REGIONS =  2;
localparam int unsigned NUM_DOMAINS =      2;
localparam int unsigned ID_WIDTH =         16;
localparam int unsigned ADDR_WIDTH =       32;
  
pu_pkg::policy_entry_t [0 : NUM_MEM_REGIONS-1][0 : NUM_DOMAINS-1] POLICY = '{
  // Domain 0, Domain 1
  {{1'b1,1'b0},{1'b0,1'b0}}, // Memory Region 0
  {{1'b0,1'b1},{1'b1,1'b0}}  // Memory Region 1 (included in Memory Region 0)
};

  logic [ID_WIDTH - 1 : 0]    ID         = '0;
  logic [ADDR_WIDTH - 1 : 0]  ADDR       = '0;
  logic [7 : 0]               LEN        = '0;
  logic [2 : 0]               SIZE       = 3'b010;  // 32 bit
  logic                       READ_WRITE = '0;      // 0 -> READ, 1 -> WRITE
  string                      CURRENT_TEST_CASE;
  logic                       GRANTED;

  typedef struct {
    // Inputs
    logic [ID_WIDTH - 1 : 0]    ID;
    logic [ADDR_WIDTH - 1 : 0]  ADDR;
    logic [7 : 0]               LEN;
    logic [2 : 0]               SIZE;
    logic READ_WRITE;
    // Expected result
    logic GRANTED;
    // Debug
    string NAME;    
  } test_case_t;

 PolicyCheck #(
     .NUM_MEM_REGIONS   ( NUM_MEM_REGIONS     ),
     .NUM_DOMAINS       ( NUM_DOMAINS         ),
     .ID_WIDTH          ( ID_WIDTH            ),
     .ADDR_WIDTH        ( ADDR_WIDTH          ),

     .MEM_REGION_0      ( 'h00000000          ), // to x"0000003F" of 64 byte
     .MEM_REGION_0_LSB  ( 'd6                 ),
     .MEM_REGION_1      ( 'h00000020          ), // to x"0000003F" of 32 byte
     .MEM_REGION_1_LSB  ( 'd5                 ),

     .DOMAIN_0_ID       ( 'b0000100000000000  ),
     .DOMAIN_0_MASK     ( 'b0001111100000011  ),
     .DOMAIN_1_ID       ( 'b0000100000000001  ),
     .DOMAIN_1_MASK     ( 'b0001111100000011  )
   ) policycheck_inst (.*);

  initial begin
    
    static test_case_t test_cases [0 : 9] = '{
    // ID                   ADDR         LEN   SIZE   R/W  GRANTED NAME
      '{'b0000100000000000, 'hx00000000, 'h00, 'b010, 'b0, 'b1,    "Simple permitted transaction"},
      '{'b0000100000000001, 'hx00000000, 'h00, 'b010, 'b0, 'b0,    "ID has no access rights"},
      '{'b0001100000000000, 'hx00000000, 'h00, 'b010, 'b0, 'b0,    "unkown ID"},
      '{'b0000100000000001, 'hx00000000, 'h00, 'b010, 'b0, 'b0,    "ADDR not accessible"},
      '{'b0000100000000000, 'hx00000040, 'h00, 'b010, 'b0, 'b0,    "ADDR not listed"},
      '{'b0000100000000000, 'hx00000000, 'h0F, 'b010, 'b0, 'b1,    "LEN just small enough"},
      '{'b0000100000000000, 'hx00000000, 'h10, 'b010, 'b0, 'b0,    "LEN to long"},
      '{'b0000100000000000, 'hx00000000, 'h00, 'b110, 'b0, 'b1,    "SIZE just small enough"},
      '{'b0000100000000000, 'hx00000000, 'h00, 'b111, 'b0, 'b0,    "SIZE to large"},
      '{'b0000100000000000, 'hx00000000, 'h00, 'b010, 'b1, 'b0,    "READ/WRITE not allowed"}
    };

    foreach (test_cases[i]) begin
      ID                 = test_cases[i].ID;
      ADDR               = test_cases[i].ADDR;
      LEN                = test_cases[i].LEN;
      SIZE               = test_cases[i].SIZE;
      READ_WRITE         = test_cases[i].READ_WRITE;
      CURRENT_TEST_CASE  = test_cases[i].NAME;

      # 20;
      
      if (GRANTED != test_cases[i].GRANTED)
        $fatal("Test failed: %s", test_cases[i].NAME);
    end
  end

endmodule