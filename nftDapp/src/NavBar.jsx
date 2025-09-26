import React from "react";
import { FaXTwitter, FaInstagram } from "react-icons/fa6";
import { SiGmail } from "react-icons/si";

const NavBar = ({ accounts, setAccounts }) => {
  const isConnected = Boolean(accounts[0]);

  const connectWallet = async () => {
    if (window.ethereum) {
      try {
        const accounts = await window.ethereum.request({
          method: "eth_requestAccounts",
        });
        setAccounts(accounts);
      } catch (error) {
        console.error("Error in fetching accounts!");
      }
    } else {
      alert("MetaMask wallet is not found!");
    }
  };

  return (
    <div className="navBar">
      {/* Left Side - Social Media Icons */}
      <div className="social-icons">
        <a href="https://x.com" target="_blank" rel="noreferrer">
          <FaXTwitter size={28} />
        </a>
        <a href="https://instagram.com" target="_blank" rel="noreferrer">
          <FaInstagram size={28} />
        </a>
        <a href="https://gmail.com">
          <SiGmail size={28} />
        </a>
      </div>

      {/* Right Side */}
      <div className="nav-links">
        <a href="#about">About</a>
        <a href="#mint">Mint</a>
        <a href="#team">Team</a>
        {isConnected ? (
          <span>✅ Connected</span>
        ) : (
          <button onClick={connectWallet}>Connect</button>
        )}
      </div>
    </div>
  );
};

export default NavBar;
