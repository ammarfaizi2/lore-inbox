Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262446AbTKIOIY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Nov 2003 09:08:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262456AbTKIOIX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Nov 2003 09:08:23 -0500
Received: from kiuru.kpnet.fi ([193.184.122.21]:36032 "EHLO kiuru.kpnet.fi")
	by vger.kernel.org with ESMTP id S262446AbTKIOH5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Nov 2003 09:07:57 -0500
Subject: Re: [PATCH 2.4] forcedeth
From: Markus =?ISO-8859-1?Q?H=E4stbacka?= <midian@ihme.org>
To: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
Cc: Kernel Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <3FAE34E1.7040808@gmx.net>
References: <3FAC837F.2070601@gmx.net> <1068323168.25759.4.camel@midux>
	 <3FAE34E1.7040808@gmx.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-kROSVzH7z12t2CqGcnQ1"
Message-Id: <1068386871.14427.5.camel@midux>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 09 Nov 2003 16:07:51 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-kROSVzH7z12t2CqGcnQ1
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

It doesn't work in any way for me.

midux:/home/midian# lspci -vvvxxx|more
00:00.0 Host bridge: nVidia Corporation nForce2 AGP (different version?)
(rev c1)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Region 0: Memory at e0000000 (32-bit, prefetchable) [size=3D64M]
        Capabilities: [40] AGP version 2.0
                Status: RQ=3D32 Iso- ArqSz=3D0 Cal=3D0 SBA+ ITACoh- GART64-
HTrans- 64bit- FW+ AGP3- Rate=3Dx1,x2,x4
                Command: RQ=3D1 ArqSz=3D0 Cal=3D0 SBA- AGP+ GART64- 64bit- =
FW+
Rate=3Dx4
        Capabilities: [60] #08 [2001]
00: de 10 e0 01 06 00 b0 00 c1 00 00 06 00 00 80 00
10: 08 00 00 e0 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 00 00 00 00
40: 02 60 20 00 17 02 00 1f 14 01 00 00 ff ff ff ff
50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
60: 08 00 01 20 20 00 88 80 10 00 00 00 01 ff 0f 8f
70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
80: 0e 01 00 00 ff ff ff 3f 01 00 00 00 01 80 00 00
90: 0e 80 e0 f2 0e 80 e0 f0 f0 0f ff 00 00 00 00 00
a0: 00 00 00 00 fb 55 7c 00 00 00 00 00 00 00 00 00
b0: cc ff 07 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 33 33 03 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: f6 01 47 00 97 30 00 10 00 00 00 00 00 00 00 00
f0: 07 00 00 38 00 00 00 00 00 00 00 00 00 00 00 00

00:00.1 RAM memory: nVidia Corporation nForce2 Memory Controller 1 (rev
c1)
        Subsystem: Unknown device 1695:1000
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
00: de 10 eb 01 00 00 20 00 c1 00 00 05 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 95 16 00 10
30: 00 00 00 00 00 00 00 00 00 00 00 00 ff 00 00 00
40: 04 00 00 70 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 16 05 42 81 01 00 00 00 01 00 00 00 01 00 00 00
70: 18 04 00 00 18 04 00 00 2c 07 00 01 40 07 00 01
80: 01 00 00 00 f3 13 0f 03 08 05 08 05 78 c8 a6 3f
90: 0b 8c 33 33 40 22 43 22 00 21 54 02 0d 22 77 07
a0: 6a 00 00 00 00 00 10 00 6a 00 00 00 00 00 10 00
b0: 6a 00 00 00 00 00 10 00 2a 00 00 00 01 00 10 00
c0: 00 31 22 02 00 00 00 00 00 00 00 00 ff ff 02 00
d0: 44 4e 00 00 22 22 00 00 0d 00 00 00 1e 00 00 00
e0: 1a 00 00 00 80 00 00 00 88 44 44 10 b1 04 30 40
f0: 10 18 1e 03 04 10 04 3f 09 44 1c 04 01 03 70 30

00:00.2 RAM memory: nVidia Corporation nForce2 Memory Controller 4 (rev
c1)
        Subsystem: Unknown device 1695:1000
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
00: de 10 ee 01 00 00 20 00 c1 00 00 05 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 95 16 00 10
30: 00 00 00 00 00 00 00 00 00 00 00 00 ff 00 00 00
40: 01 20 da 12 00 00 00 02 01 20 da 12 01 00 37 1f
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: ff 3f ff 07 ff ff 7f 05 ff ff cf 06 ff bf df 06
80: ff ff ef 06 ff ff dd 07 ff df ff 02 ff 5f fd 03
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 f5 02 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 40 00 00 00 00 00 00 00 00 00 00 00
d0: 11 00 00 00 04 00 00 00 00 00 00 e0 ff ff ff e3
e0: 01 00 ca 36 01 00 ca 36 01 00 ca 36 01 00 ca 36
f0: 01 00 ca 36 01 00 ca 36 01 00 ca 36 01 00 ca 36

00:00.3 RAM memory: nVidia Corporation nForce2 Memory Controller 3 (rev
c1)
        Subsystem: Unknown device 1695:1000
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
00: de 10 ed 01 00 00 20 00 c1 00 00 05 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 95 16 00 10
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 30 00 00 00 00 90 00 00 63 00 00 00 71 07 00 00
50: 76 06 00 00 72 95 00 00 68 ea 00 00 50 40 20 00
60: e9 00 00 00 00 06 f7 67 00 ea aa aa 88 ba 00 77
70: 01 80 e0 01 6a 00 00 00 03 10 01 20 55 00 02 01
80: ff ff 00 00 ff ff ff ff 00 00 00 00 00 00 00 00
90: ff 10 ff 10 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: ff 30 00 00 ff 30 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 04 40 00 00 ff ff ff ff
f0: 1c 40 00 00 ff ff ff ff ff ff ff ff ff ff ff ff

00:00.4 RAM memory: nVidia Corporation nForce2 Memory Controller 2 (rev
c1)
        Subsystem: Unknown device 1695:1000
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
00: de 10 ec 01 00 00 20 00 c1 00 00 05 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 95 16 00 10
30: 00 00 00 00 00 00 00 00 00 00 00 00 ff 00 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: aa 33 aa 33 aa 33 aa 33 aa 33 aa 33 aa 33 aa 33
70: ff 99 ff 99 f0 00 00 00 7f 3e e0 0f aa 33 aa 33
80: ff 99 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 45 45 45 45 43 43 44 43 10 10 10 10 10 10 10 10
a0: 00 00 00 00 aa aa 00 80 00 00 00 00 5f 05 a0 00
b0: 78 56 34 12 ef cd ab 89 9b 4a 66 22 ee bd dc 8b
c0: 66 06 53 07 00 00 00 00 55 55 55 00 00 00 00 00
d0: ff 20 ff 20 ff 20 ff 7f 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:00.5 RAM memory: nVidia Corporation nForce2 Memory Controller 5 (rev
c1)
        Subsystem: Unknown device 1695:1000
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
00: de 10 ef 01 00 00 20 00 c1 00 00 05 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 95 16 00 10
30: 00 00 00 00 00 00 00 00 00 00 00 00 ff 00 00 00
40: 00 00 00 00 00 00 00 00 39 e9 f4 09 39 e9 f4 09
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 ff ff ff 3f 00 00 00 00 ff ff ff 3f
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:01.0 ISA bridge: nVidia Corporation nForce2 ISA Bridge (rev a4)
        Subsystem: Unknown device 1695:1000
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: [48] #08 [01e1]
00: de 10 60 00 0f 00 b0 00 a4 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 95 16 00 10
30: 00 00 00 00 48 00 00 00 00 00 00 00 00 00 00 00
40: 95 16 00 10 de fd 3c 08 08 00 e1 01 60 00 88 88
50: a0 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 01 40 00 00 01 44 00 00 01 42 00 00 00 00 f8 ff
70: 10 00 ff ff 03 00 00 00 0f 00 70 00 70 bc 00 00
80: 09 3a 00 00 4b 0a 00 00 3f 00 00 00 00 00 00 00
90: 00 00 33 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: cc 00 02 00 0a 00 00 00 00 00 00 00 00 00 00 00
e0: 00 10 00 07 0f 50 00 00 00 38 26 08 00 00 00 00
f0: 00 ff 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:01.1 SMBus: nVidia Corporation nForce2 SMBus (MCP) (rev a2)
        Subsystem: Unknown device 1695:1000
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at ec00 [size=3D32]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
PME(D0-,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
00: de 10 64 00 01 00 b0 00 a2 00 05 0c 00 00 80 00
10: 01 ec 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 95 16 00 10
30: 00 00 00 00 44 00 00 00 00 00 00 00 0a 01 03 01
40: 95 16 00 10 01 00 02 c0 00 00 00 00 00 00 00 00
50: 01 50 00 00 01 51 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:02.0 USB Controller: nVidia Corporation nForce2 USB Controller (rev
a4) (prog-if 10 [OHCI])
        Subsystem: Unknown device 1695:1000
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (750ns min, 250ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at e7002000 (32-bit, non-prefetchable)
[size=3D4K]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
00: de 10 67 00 07 00 b0 00 a4 10 03 0c 00 00 80 00
10: 00 20 00 e7 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 95 16 00 10
30: 00 00 00 00 44 00 00 00 00 00 00 00 0b 01 03 01
40: 95 16 00 10 01 00 02 fe 00 00 00 00 02 00 00 00
50: 00 00 00 00 1d 47 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:02.1 USB Controller: nVidia Corporation nForce2 USB Controller (rev
a4) (prog-if 10 [OHCI])
        Subsystem: Unknown device 1695:1000
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (750ns min, 250ns max)
        Interrupt: pin B routed to IRQ 4
        Region 0: Memory at e7003000 (32-bit, non-prefetchable)
[size=3D4K]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
00: de 10 67 00 07 00 b0 00 a4 10 03 0c 00 00 80 00
10: 00 30 00 e7 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 95 16 00 10
30: 00 00 00 00 44 00 00 00 00 00 00 00 04 02 03 01
40: 95 16 00 10 01 00 02 fe 00 00 00 00 03 00 00 00
50: 0c 00 00 00 1d 47 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:02.2 USB Controller: nVidia Corporation nForce2 USB Controller (rev
a4) (prog-if 20 [EHCI])
        Subsystem: Unknown device 1695:1000
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (750ns min, 250ns max)
        Interrupt: pin C routed to IRQ 3
        Region 0: Memory at e7004000 (32-bit, non-prefetchable)
[size=3D256]
        Capabilities: [44] #0a [2080]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
00: de 10 68 00 06 00 b0 00 a4 20 03 0c 00 00 80 00
10: 00 40 00 e7 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 95 16 00 10
30: 00 00 00 00 44 00 00 00 00 00 00 00 03 03 03 01
40: 95 16 00 10 0a 80 80 20 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 20 20 01 00 00 60 98 81 c3 13 00 00 00 00 00 00
70: 00 00 00 05 00 10 20 80 89 3d 84 22 e7 25 04 80
80: 01 00 02 fe 00 00 00 00 00 00 00 00 15 16 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 01 00 00 00 00 00 0c c0 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:04.0 Ethernet controller: nVidia Corporation nForce2 Ethernet
Controller (rev a1)
        Subsystem: Unknown device 1695:1000
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (250ns min, 5000ns max)
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at e7000000 (32-bit, non-prefetchable)
[size=3D4K]
        Region 1: I/O ports at e000 [size=3D8]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
00: de 10 66 00 07 00 b0 00 a1 00 00 02 00 00 00 00
10: 00 00 00 e7 01 e0 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 95 16 00 10
30: 00 00 00 00 44 00 00 00 00 00 00 00 0a 01 01 14
40: 95 16 00 10 01 00 02 fe 00 00 00 00 04 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:08.0 PCI bridge: nVidia Corporation nForce2 External PCI Bridge (rev
a3) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=3D=
32
        I/O behind bridge: 0000d000-0000dfff
        Memory behind bridge: e6000000-e6ffffff
        Prefetchable memory behind bridge: fff00000-000fffff
        BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
00: de 10 6c 00 07 01 a0 00 a3 00 04 06 00 00 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 20 d0 d0 80 22
20: 00 e6 f0 e6 f0 ff 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02 00
40: 00 00 00 00 01 00 02 00 01 00 00 00 08 0b 05 00
50: 0c 0d fe 3f 0e 0f 00 00 7f 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:09.0 IDE interface: nVidia Corporation nForce2 IDE (rev a2) (prog-if
8a [Master SecP PriP])
        Subsystem: Unknown device 1695:1000
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (750ns min, 250ns max)
        Region 4: I/O ports at f000 [size=3D16]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
00: de 10 65 00 05 00 b0 00 a2 8a 01 01 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 f0 00 00 00 00 00 00 00 00 00 00 95 16 00 10
30: 00 00 00 00 44 00 00 00 00 00 00 00 00 00 03 01
40: 95 16 00 10 01 00 02 00 00 00 00 00 00 09 00 00
50: 03 f0 00 00 00 00 00 00 20 20 20 20 00 00 20 20
60: c5 c0 c6 c6 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 80 6b 1f 00 00 02 0c 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:1e.0 PCI bridge: nVidia Corporation nForce2 AGP (rev c1) (prog-if 00
[Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Bus: primary=3D00, secondary=3D02, subordinate=3D02, sec-latency=3D=
32
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: e4000000-e5ffffff
        Prefetchable memory behind bridge: d0000000-dfffffff
        BridgeCtl: Parity- SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-
00: de 10 e8 01 07 01 20 02 c1 00 04 06 00 20 01 00
10: 00 00 00 00 00 00 00 00 00 02 02 20 f0 00 20 22
20: 00 e4 f0 e5 00 d0 f0 df 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0a 00
40: 01 00 00 00 00 00 f0 3f 20 00 00 00 ff ff ff ff
50: 00 00 00 e0 00 f0 ff e3 ff ff ff ff ff ff ff ff
60: ff 40 ff 60 00 00 00 20 00 00 00 00 ff ff ff ff
70: ff ff ff ff 00 00 00 00 00 00 00 00 ff ff ff ff
80: ff ff ff ff 00 80 00 00 89 01 00 00 ff ff ff ff
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
a0: 17 02 00 1f ff ff ff ff ff ff ff ff ff ff ff ff
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff

01:06.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev
07)
        Subsystem: Creative Labs SB Live! 5.1 Model SB0100
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (500ns min, 5000ns max)
        Interrupt: pin A routed to IRQ 12
        Region 0: I/O ports at d000 [size=3D32]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
00: 02 11 02 00 05 00 90 02 07 00 01 04 00 20 80 00
10: 01 d0 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 02 11 64 80
30: 00 00 00 00 dc 00 00 00 00 00 00 00 0c 01 02 14
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 01 00 01 06
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

01:06.1 Input device controller: Creative Labs SB Live! MIDI/Game Port
(rev 07)
        Subsystem: Creative Labs Gameport Joystick
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 0: I/O ports at d400 [size=3D8]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
00: 02 11 02 70 05 00 90 02 07 00 80 09 00 20 80 00
10: 01 d4 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 02 11 20 00
30: 00 00 00 00 dc 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 01 00 01 06
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

01:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8139/8139C/8139C+ (rev 10)
        Subsystem: Unknown device 1695:9001
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (8000ns min, 16000ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at d800 [size=3D256]
        Region 1: Memory at e6010000 (32-bit, non-prefetchable)
[size=3D256]
        Expansion ROM at <unassigned> [disabled] [size=3D64K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D375mA
PME(D0-,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
00: ec 10 39 81 07 00 90 02 10 00 00 02 00 20 00 00
10: 01 d8 00 00 00 00 01 e6 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 95 16 01 90
30: 00 00 00 00 50 00 00 00 00 00 00 00 0b 01 20 40
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 01 00 c2 f7 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

01:0d.0 FireWire (IEEE 1394): Lucent Microelectronics FW323 (rev 61)
(prog-if 10 [OHCI])
        Subsystem: Unknown device 1695:9015
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (3000ns min, 6000ns max), Cache Line Size: 0x08 (32
bytes)
        Interrupt: pin A routed to IRQ 7
        Region 0: Memory at e6011000 (32-bit, non-prefetchable)
[size=3D4K]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA
PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
00: c1 11 11 58 06 00 90 02 61 10 00 0c 08 20 00 00
10: 00 10 01 e6 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 95 16 15 90
30: 00 00 00 00 44 00 00 00 00 00 00 00 07 01 0c 18
40: 00 00 00 00 01 00 02 7e 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 61 04 00 10 6b 04 00 00 00 00 00 00 00 00 00
80: 00 61 04 00 10 6b 04 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

02:00.0 VGA compatible controller: nVidia Corporation NV17 [GeForce4 MX
440] (rev a3) (prog-if 00 [VGA])
        Subsystem: Micro-Star International Co., Ltd.: Unknown device
8611
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 248 (1250ns min, 250ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at e4000000 (32-bit, non-prefetchable)
[size=3D16M]
        Region 1: Memory at d0000000 (32-bit, prefetchable) [size=3D128M]
        Region 2: Memory at d8000000 (32-bit, prefetchable) [size=3D512K]
        Expansion ROM at <unassigned> [disabled] [size=3D128K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
        Capabilities: [44] AGP version 2.0
                Status: RQ=3D32 Iso- ArqSz=3D0 Cal=3D0 SBA- ITACoh- GART64-
HTrans- 64bit- FW+ AGP3- Rate=3Dx1,x2,x4
                Command: RQ=3D32 ArqSz=3D0 Cal=3D0 SBA- AGP+ GART64- 64bit-
FW+ Rate=3Dx4
00: de 10 71 01 07 00 b0 02 a3 00 00 03 00 f8 00 00
10: 00 00 00 e4 08 00 00 d0 08 00 00 d8 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 62 14 11 86
30: 00 00 00 00 60 00 00 00 00 00 00 00 0b 01 05 01
40: 62 14 11 86 02 00 20 00 17 00 00 1f 14 01 00 1f
50: 01 00 00 00 01 00 00 00 ce d6 23 00 0f 00 00 00
60: 01 44 02 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
su, 2003-11-09 kello 14:36, Carl-Daniel Hailfinger kirjoitti:
> Markus H=E4stbacka wrote:
> > I tested this driver for my Nforce2 mobo on 2.6.0-test9, and this drive=
r
> > seemed useless, it just printed some random numbers in my konsole (And
> > trust me, it was hard to edit lilo.conf so I even could boot back to ol=
d
> > kernel when all the numbers just were jumping around) And it broke the
> > other card too, ifconfig was right, now there was this card too, but no
> > one from them worked. Thanks anyway.
>=20
> Does it work with nvnet? Could you mail me the logs and the output of
> lspci -vvvxxx
> as root? Running lspci as user will not give enough info.
>=20
> Thanks,
> Carl-Daniel
--=20
"Software is like sex, it's better when it's free."
Markus H=E4stbacka <midian at ihme.org>

--=-kROSVzH7z12t2CqGcnQ1
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Digitaalisesti allekirjoitettu viestin osa

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/rko33+NhIWS1JHARAkT9AJ9y/iwbNzXamIqAeZkv2BORSy8MZgCfflmO
8RLIfcdu66y2F7AFMxRxQZI=
=UJz2
-----END PGP SIGNATURE-----

--=-kROSVzH7z12t2CqGcnQ1--

