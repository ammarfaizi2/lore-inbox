Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314278AbSD0QaY>; Sat, 27 Apr 2002 12:30:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314280AbSD0QaY>; Sat, 27 Apr 2002 12:30:24 -0400
Received: from w226.z064000207.nyc-ny.dsl.cnc.net ([64.0.207.226]:20022 "EHLO
	carey-server.stronghold.to") by vger.kernel.org with ESMTP
	id <S314278AbSD0QaW>; Sat, 27 Apr 2002 12:30:22 -0400
Message-Id: <4.3.2.7.2.20020427120007.03a57800@mail.strongholdtech.com>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Sat, 27 Apr 2002 12:35:52 -0400
To: tanner@real-time.com
From: "Nicolae P. Costescu" <nick@strongholdtech.com>
Subject: Re: BIOS says MP, kernel says XP was PROBLEM: Dual (2) AMD
  ATHLON MP 1900+ CPUs gives APIC error on CPU[0]: 00(02)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E171U0D-0008PV-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The behavior you originally described, and the bootup output (where the 
kernel reports the CPUs as XPs) might indicate you're really running XPs.

Especially the part where the system runs fine when only 1 CPU is 
installed. That's what a lot of XP users report.

I know you checked the box, but maybe to be sure you can emove the heatsink 
(make sure you have spare thermal compound handy for when you replace it) 
and check on the core, is it a 1900XP or 1900MP.

I have several Tyan 2466N and 2466N-4M and all report the CPUs as 1900+ MPs 
when the kernel boots.

Another user reported stability issues that turned out to be his MP CPUs. 
He was able to move them to other motherboards and cause the stability 
problems. In the end he had to swap CPUs. I'll ask him to email you 
directly perhaps he can help. He has your motherboard as well.



****************************************************
Nicolae P. Costescu, Ph.D.  / Senior Developer
Stronghold Technologies
46040 Center Oak Plaza, Suite 160 / Sterling, Va 20166
Tel: 571-434-1472 / Fax: 571-434-1478

