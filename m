Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262086AbTKTSKl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 13:10:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262109AbTKTSKl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 13:10:41 -0500
Received: from smtp.dkm.cz ([62.24.64.34]:62992 "HELO smtp.dkm.cz")
	by vger.kernel.org with SMTP id S262086AbTKTSKb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 13:10:31 -0500
From: "Michal Semler (volny.cz)" <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: linux-kernel@vger.kernel.org
Subject: XI-325H and Acer TravelMate 242
Date: Thu, 20 Nov 2003 19:10:32 +0100
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311201910.32039.cijoml@volny.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have bought ZCOM XI-325H Prism2 based card into PCMCIA slot.

After plugging into slot leds starts shining, but card is not shown in lspci.
Under WinXP card works normally!!

My ethernet card into PCMCIA slot works perfectly and is shown in lspci

Can somebody help me? This card is very expensive and I need it to get it work 
under Linux :((

notas:~# lspci
00:00.0 Host bridge: Intel Corp. 82852/855GM Host Bridge (rev 02)
00:00.1 System peripheral: Intel Corp.: Unknown device 3584 (rev 02)
00:00.3 System peripheral: Intel Corp.: Unknown device 3585 (rev 02)
00:02.0 VGA compatible controller: Intel Corp. 82852/855GM Integrated Graphics 
Device (rev 02)
00:02.1 Display controller: Intel Corp. 82852/855GM Integrated Graphics Device 
(rev 02)
00:1d.0 USB Controller: Intel Corp. 82801DB USB (Hub  (rev 03)
00:1d.1 USB Controller: Intel Corp. 82801DB USB (Hub  (rev 03)
00:1d.2 USB Controller: Intel Corp. 82801DB USB (Hub  (rev 03)
00:1d.7 USB Controller: Intel Corp. 82801DB USB2 (rev 03)
00:1e.0 PCI bridge: Intel Corp. 82801BAM/CAM PCI Bridge (rev 83)
00:1f.0 ISA bridge: Intel Corp. 82801DBM LPC Interface Controller (rev 03)
00:1f.1 IDE interface: Intel Corp. 82801DBM Ultra ATA Storage Controller (rev 
03)
00:1f.3 SMBus: Intel Corp. 82801DB/DBM SMBus Controller (rev 03)
00:1f.5 Multimedia audio controller: Intel Corp. 82801DB AC'97 Audio 
Controller (rev 03)
00:1f.6 Modem: Intel Corp. 82801DB AC'97 Modem Controller (rev 03)
02:04.0 CardBus bridge: Texas Instruments PCI1250 PC card Cardbus Controller 
(rev 01)
02:04.1 CardBus bridge: Texas Instruments PCI1250 PC card Cardbus Controller 
(rev 01)
02:0a.0 Ethernet controller: Realtek Semiconductor Co., Ltd. 
RTL-8139/8139C/8139C+ (rev 10)


Michal

