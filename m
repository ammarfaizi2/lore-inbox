Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264221AbTFCHws (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 03:52:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264505AbTFCHws
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 03:52:48 -0400
Received: from [62.189.51.14] ([62.189.51.14]:2572 "EHLO klint.chant.com")
	by vger.kernel.org with ESMTP id S264221AbTFCHwr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 03:52:47 -0400
Message-ID: <0060478E58FDD611A4A200508BCF7BD97BF752@pleyel.chant.com>
From: "Laurent Pierre (MIS)" <Pierre.Laurent2@eurotunnel.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Cc: "'laurentpi@free.fr'" <laurentpi@free.fr>
Subject: VIA CHIPSET KT 400 / 8235 troubleshooting
Date: Tue, 3 Jun 2003 10:06:10 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hello,
> 
> I'm having some problems with my new hardware and I was told in a forum to
> contact you to get more information.
> 
> I am using a pc based upon the following configuration : 
> Processor : ATHLON XP 2000+ 
> Memory : 512 MO 
> Motherboard : DFI AD77 ( KT 400 / 8235 chipset. ) 
> Video Card : Leadtek Winfast A 180 DDR T 
> 
> The motherboard has been already patch with the bios's last version found
> at <http://www.dfi.com.tw/Upload/BIOS/Ad770311.zip> 
> 
> I've installed Mandrake 9.1 RC2 
> 
> Everytime , my pc hangs during the installation and i have the following
> messages : 
> 
> - CPU AMD Athlon (tm) XP 2000+ stepping 00 
> - Enabling Fast FPU save and restore ... done 
> - Enabling unmasked SIMD FPU exception support... done 
> - Checking 'hlt' instruction... OK 
> - Checking for popad bug... OK 
> - POSIX conformance testing by UNIFIX 
> - enabled ExtINT on CPU #0 
> - ESR value before enabling vector : 00000002 
> 
> I have tried to disable the USB ports without success. 
> I've tried to activate / deactivate the ACPI mode as well, but nothing. 
> I've applied the latest BIOS patch from DFI. 
> Thus, the problem seems to be between the APIC and the kernel version. 
> 
> I tried again yesterday to install  Mandrake 9.1 RC2 and it hangs... 
> 
> i've tried an Manual install and i've choosen a older kernel version (
> which is given in Mandrake's advanced installation menu ) , and
> installation was ok ! BUT when booting for the first time after choosing
> Mandrake in the LILO menu, the PC hangs with the same error message... 
> 
> I've tried to activate / deactivate APIC : No result. 
> 
> I would really appreciate any help or advice you could offer on this
> problem.
> Thanks in advance. 
> 
> Pierre Laurent 


==========================================================================
This message and any attachments are confidential and may also be
privileged.
Its contents do not constitute a commitment by the Channel Tunnel Group Ltd 
and/or France-Manche S.A. except where provided for in a written agreement
between you and The Channel Tunnel Group Ltd and/or France-Manche S.A.
Any unauthorised disclosure, use or dissemination, either whole or partial
is prohibited. If you are not the intended recipient of the message, please
notify the sender immediately. The views expressed in this message do not
necessarily reflect those of The Channel Tunnel Group Ltd and/or
France-Manche
S.A. or any of their subsidiary companies.

