Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282099AbRKWJsR>; Fri, 23 Nov 2001 04:48:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282095AbRKWJsB>; Fri, 23 Nov 2001 04:48:01 -0500
Received: from mgw-x2.nokia.com ([131.228.20.22]:5837 "EHLO mgw-x2.nokia.com")
	by vger.kernel.org with ESMTP id <S282099AbRKWJrn>;
	Fri, 23 Nov 2001 04:47:43 -0500
Message-ID: <3BFE19B6.4070907@nokia.com>
Date: Fri, 23 Nov 2001 11:41:10 +0200
From: Dmitri Kassatkine <dmitri.kassatkine@nokia.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011023
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>, linux-netdev@vger.kernel.org,
        linux-net@vger.kernel.org
CC: "Vilavaara Asko (NRC/Helsinki)" <asko.vilavaara@nokia.com>,
        "Juopperi Jari (NRC/Helsinki)" <jari.juopperi@nokia.com>,
        "Deak Imre (EXT-Syntact/Helsinki)" <ext-imre.deak@nokia.com>,
        Dmitri Kassatkine <Dmitri.Kassatkine@nokia.com>
Subject: Affix Bluetooth Protocol Stack for Linux  -> http://www-nrc.nokia.com/affix
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linux folks,

Nokia Research Center has decided to release Affix Bluetooth software for
Linux under GPL. Affix implements a set of core Bluetooth protocols such 
as L2CAP,
RFCOMM, SDP as well as a set of Bluetooth profiles.It can be compiled as 
a collection
of modules or linked statically into the kernel.

Affix is designed to support relevant Nokia products e.g., Nokia 
Connectivity Card (DTL-1).
During the development, however, the following pieces of hardware have 
also been used with
Affix:
- NSM Bluetooth USB dongle (NSC chipset based);
- CSR Bluetooth USB module;
- Socket Communications Compact Flash Card.
- Taiyo Youden USB module.

Affix implements currently the following Bluetooth Profiles:
- Serial Port Profile;
- Dialup Networking Profile;
- LAN Access Profile;
- OBEX Object Push Profile;
- OBEX File Transfer Profile;

Other Affix features:
- Modular implementation (includes kernel patch);
- Well defined API (Including Socket Interface for L2CAP and RFCOMM)
- Hardware abstraction. (interface to implement transport driver -
  PCMCIA, USB, UART).
- SMP safe;

We successfully tested Affix for interoperability with Nokia Bluetooth
Phone 6210 with Bluetooth battery pack, Digianswer stack for Windows,
Compaq iPaq,  Bluetooth stack for Palm OS. For more information please
refer to README from the Affix package.

While we believe that Affix is an useful piece of software, please bear in
mind that it is not an official Nokia product, but a result of the
research activity of Nokia Research Center. For further details, please 
read
the files README, LICENSE, COPYING and LEGAL in the tar archive.

Affix WEB page:
http://www-nrc.nokia.com/affix


Best Regards,
Dmitri Kassatkine and other Affix team members
Nokia Research Center

-- 
 Dmitri Kassatkine
 Nokia Research Center / Helsinki
 Mobile: +358 50 4836365
 E-Mail: dmitri.kassatkine@nokia.com


