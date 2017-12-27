class fifo_driver extends uvm_driver #(simple_item);
  simple_item s_item;
  virtual dut_if vif;

  //factory registration
  `uvm_component_utils(fifo_driver);

  //constructor
  function new (string name="fifo_driver", uvm_component parent);
    super.new(name, parent);
  endfunction : new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual dut_if)::get(this,“”,"vif",vif))
    `uvm_fatal("NOVIF", {"virtual interface must be set for: ", get_full_name(),".vif"});
  endfunction : build_phase

  task run_phase(uvm_phase phase);
    // Get the next data item from sequencer (may block).
    seq_item_port.get_next_item(s_item);

    // Execute the item
    drive_item(s_item);

    seq_item_port.item_done(); // Consume the request
    end
  endtask: run_phase

  task drive_item (input simple_item item);
    //logic here
  endtask : drive_item

endclass : fifo_driver