Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132867AbRDQV1y>; Tue, 17 Apr 2001 17:27:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132868AbRDQV1q>; Tue, 17 Apr 2001 17:27:46 -0400
Received: from verlaine.noos.net ([212.198.2.73]:62070 "EHLO mail.noos.fr")
	by vger.kernel.org with ESMTP id <S132867AbRDQV1d>;
	Tue, 17 Apr 2001 17:27:33 -0400
Message-ID: <3ADCB4C3.18BB41CB@noos.fr>
Date: Tue, 17 Apr 2001 23:25:24 +0200
From: battata chafik <battata.chafik@cyberacble.fr>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: andrewm@uow.edu.au, netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: thank's for answering 
Content-Type: multipart/mixed;
 boundary="------------EBFD5077213C5B00045965C3"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------EBFD5077213C5B00045965C3
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

this is my problem
i have a 3c595TX card and when i plus it in my hub it at 10base T i
tride to put the new modules and nothing changed i have a 2.2.16 kernel
and 2.4.1 kenel and it's the same in the too cases ,
and i have to other computer using a 100base T cards from real tek and
they  appear at 100 base T in the hub and te rate of any fule transfert
is up to 10 mb/s  between the to other computer , so is there any
upgrade to do for the bios of the nic card or is it normal " i don't
think so but why not "

sorry for my poor english i try to do my best

--------------EBFD5077213C5B00045965C3
Content-Type: text/plain; charset=us-ascii;
 name="3con595TX"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="3con595TX"

00:0a.0 Ethernet controller: 3Com Corporation 3c595 100BaseTX [Vortex]
        Flags: bus master, medium devsel, latency 248, IRQ 18
        I/O ports at e800 [size=32]
        Expansion ROM at eb000000 [disabled] [size=64K]
00: b7 10 50 59 07 00 00 02 00 00 00 02 00 f8 00 00
10: 01 e8 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 eb 00 00 00 00 00 00 00 00 05 01 03 08


100 base T hubed 





vortex-diag.c:v2.04 1/8/2001 Donald Becker (becker@scyld.com)
 http://www.scyld.com/diag/index.html
Index #1: Found a 3Com 3c595 Vortex 10/100baseTx adapter at 0xe800.
The Vortex chip may be active, so FIFO registers will not be read.
To see all register values use the '-f' flag.
Initial window 7, registers values by window:
  Window 0: 0000 0000 0000 0000 0000 00bf 0000 0000.
  Window 1: FIFO FIFO 0000 2000 8000 00ff 3ffc 2000.
  Window 2: a000 8a24 1c66 0000 0000 0000 00de 4000.
  Window 3: 001b 0001 0000 0020 e10a bfff 3fff 6000.
  Window 4: 0000 00d4 0000 0c80 0001 88c0 0000 8000.
  Window 5: 1ffc 1ffc 00de 1ffc 0007 02de 00de a000.
  Window 6: 0000 0000 0000 3000 0000 4e5b 2bb7 c000.
  Window 7: 0000 0000 0000 0000 8000 00ff 0000 e000.
Vortex chip registers at 0xe800
  0xE810: **FIFO** 00000000 00008000 *STATUS*
  0xE820: ffffffff ffffffff ffffffff ffffffff
  0xE830: ffffffff ffffffff ffffffff ffffffff
 Indication enable is 00de, interrupt enable is 02de.
 No interrupt sources are pending.
 Transceiver/media interfaces available:  100baseTx 10baseT.
Transceiver type in use:  10baseT.
 MAC settings: full-duplex.
Maximum packet size is 0.
 Station address set to 00:a0:24:8a:66:1c.
 Configuration options 00de.
EEPROM contents (64 words, offset 0):
 0x000: 00a0 248a 661c 5950 c095 0036 5542 6d50
 0x008: 0418 0000 00a0 248a 661c bf20 0000 0000
 0x010: 11c6 0000 001b 0001 0000 0000 0000 000e
 0x018: 0000 0000 0000 0000 0000 0000 0000 0000
 0x020: 0000 0000 0000 0000 0000 0000 0000 0000
 0x028: 0000 0000 0000 0000 0000 0000 0000 0000
 0x030: 0000 0000 0000 0000 0000 0000 0000 0000
 0x038: 0000 0000 0000 0000 0000 0000 0000 0000
 The word-wide EEPROM checksum is 0xc861.
Parsing the EEPROM of a 3Com Vortex/Boomerang:
 3Com Node Address 00:A0:24:8A:66:1C (used as a unique ID only).
 OEM Station address 00:A0:24:8A:66:1C (used as the ethernet address).
 Manufacture date (MM/DD/YYYY) 4/21/1996, division 6, product BU.
Options: force full-duplex.
  Vortex format checksum is correct (000e vs. 000e).
  Cyclone format checksum is correct (00 vs. 00).
  Hurricane format checksum is correct (00 vs. 00).



eth0      Link encap:Ethernet  HWaddr 00:A0:24:8A:66:1C
          inet addr:192.168.0.10  Bcast:192.168.0.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:9656 errors:200 dropped:200 overruns:0 frame:311
          TX packets:9779 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:100
          RX bytes:5767681 (5.5 Mb)  TX bytes:1539404 (1.4 Mb)
          Interrupt:18 Base address:0xe800

--------------EBFD5077213C5B00045965C3--

