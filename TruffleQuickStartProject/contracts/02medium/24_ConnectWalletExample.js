import { useState, useEffect} from 'react';
import { ethers } from "ethers";
import Link from 'next/link';

function Home() {
    const [account, setAccount] = useState();
    const [balance, setBalance] = useState();
    const [provider, setProvider] = useState();

    function conncetOnclick() {
        if(!window.etherum) {
            return;
        }
        const providerWeb3 = new ethers.providers.Web3Provider(window.etherum);
        setProvider(providerWeb3);
        providerWeb3.send("eth_requestAccounts", [])
        .then((accounts) => {
            setAccount(accounts[0]);
        })

        //单击后监听
        etherum.on("accountsChanged", function(accountsChange) {
            setAccount(accountsChange[0]);
        })        
        // const connection = async()=> {
        //     const accounts = await ethers.request({method:'eth_requestAccounts'});
        //     setAccount(accounts);
        // }
        // connection();
    }

    useEffect(() => {
        if (!window.etherum || !provider || !account) {
            return
        }
        provider.getBalance(account).then((result) => {
            setBalance(ethers.utils.formatEther(result))
        })
    }, [account]);

    return(
        <dev>Hello World
            <button onClick={conncetOnclick}>Connect Wallet</button>
            <span>Address : {account} </span>
            <span>Balance : {balance} </span>
        </dev>
    )
}
export default Home;