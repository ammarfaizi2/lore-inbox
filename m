Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310910AbSCHPZQ>; Fri, 8 Mar 2002 10:25:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310911AbSCHPZE>; Fri, 8 Mar 2002 10:25:04 -0500
Received: from nycsmtp1out.rdc-nyc.rr.com ([24.29.99.226]:13993 "EHLO
	nycsmtp1out.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id <S310910AbSCHPY7>; Fri, 8 Mar 2002 10:24:59 -0500
Message-ID: <3C88D77F.6010404@linuxhq.com>
Date: Fri, 08 Mar 2002 10:23:43 -0500
From: John Weber <john.weber@linuxhq.com>
Organization: Linux Headquarters
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020206
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Linux 2.5.6-pre3 Strangeness
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My linux-2.5.6-pre3 kernel causes some sort of crash at boot, which 
immediately causes my machine to reboot.  I can't really tell you what 
flashes on the screen, and I can't find anything in the usual logs.
Linux 2.5.6-pre2 works fine.

My machine:
- Toshiba Tecra 8100/ PIII650 MHz / 128 MB RAM / 6.4 GB HD
- lspci:
00:00.0 Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge 
(rev 03)
00:01.0 PCI bridge: Intel Corporation 440BX/ZX - 82443BX/ZX AGP bridge 
(rev 03)
00:05.0 Bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
00:05.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01)
00:05.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01)
00:05.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 03)
00:07.0 Communication controller: Lucent Microelectronics 56k WinModem 
(rev 01)
00:09.0 IRDA controller: Toshiba America Info Systems FIR Port Type-DO
00:0b.0 CardBus bridge: Toshiba America Info Systems ToPIC95 PCI to 
Cardbus Bridge with ZV Support (rev 20)
00:0b.1 CardBus bridge: Toshiba America Info Systems ToPIC95 PCI to 
Cardbus Bridge with ZV Support (rev 20)
00:0c.0 Multimedia audio controller: Yamaha Corporation YMF-744B [DS-1S 
Audio Controller] (rev 02)
01:00.0 VGA compatible controller: S3 Inc. 86C270-294 Savage/MX-/IX (rev 11)

(o- j o h n   e   w e b e r
//\  http://www.linuxhq.com/people/weber/
v_/_ john.weber@linuxhq.com

