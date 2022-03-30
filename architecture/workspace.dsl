workspace {

    model {
        heliumMiner = softwareSystem "Helium Miner"
        kasaSmartPlug = softwareSystem "Kasa Smart Plug"
        kasaRemoteService = softwareSystem "Kasa Smart Plug Remote Service"

        heliumMinerManager = softwareSystem "Helium Miner Manager" {
            minerKeeper = container "Rust Process in Rasperry Pi"
        }


        heliumMinerManager -> heliumMiner "Make HTTP request to"
        heliumMinerManager -> kasaRemoteService "Make HTTP request to"
        kasaRemoteService -> kasaSmartPlug "Send command to"
        kasaSmartPlug -> heliumMiner "Turn on/off"
    }

    views {
        systemLandscape heliumMining "Helium mining" {
            include *
            autoLayout
        }

        systemContext heliumMinerManager "HeliumMinerManager" {
            include *
            autoLayout
        }

        dynamic heliumMinerManager keepMinerWorking "Make sure miner is online and mining Helium." {
            minerKeeper -> heliumMiner "Check if miner is healthy." "Http"
            minerKeeper -> kasaRemoteService "Turn smart plug on and off." "Http"
            kasaRemoteService -> heliumMiner "Restart" "Power on and off"

            autoLayout
        }

        theme default
    }

}
