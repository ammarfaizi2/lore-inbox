Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276195AbRI1RfK>; Fri, 28 Sep 2001 13:35:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276193AbRI1Rev>; Fri, 28 Sep 2001 13:34:51 -0400
Received: from mail.spylog.com ([194.67.35.220]:52666 "HELO mail.spylog.com")
	by vger.kernel.org with SMTP id <S276191AbRI1Rea>;
	Fri, 28 Sep 2001 13:34:30 -0400
Date: Fri, 28 Sep 2001 21:31:00 +0400
From: "Oleg A. Yurlov" <kris@spylog.com>
X-Mailer: The Bat! (v1.53d)
Reply-To: "Oleg A. Yurlov" <kris@spylog.com>
Organization: SpyLOG Ltd.
X-Priority: 3 (Normal)
Message-ID: <261197249533.20010928213100@spylog.com>
To: linux-kernel@vger.kernel.org
Cc: admin@spylog.com
Subject: IO-APIC
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


        Hi, folks :-)

        I boot server and see next in dmesg:

ENABLING IO-APIC IRQs
BIOS bug, IO-APIC#0 ID 0 is already used!...
... fixing up to 1. (tell your hw vendor)
...changing IO-APIC physical APIC ID to 1 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 1-0, 1-7, 1-9, 1-10, 1-11, 1-16, 1-17, 1-18, 1-22, 1-23 not connected.
..TIMER: vector=0x31 pin1=2 pin2=0
number of MP IRQ sources: 17.
number of IO-APIC #1 registers: 24.
testing the IO APIC.......................

        What I can do with this stuff ?

        M/b   Intel  L440GX, BIOS version - 14.1, used 1 CPU, 2 Gb RAM. Kernel -
2.4.10.SuSE-3    from   mantel@suse.de   (basically  2.4.10aa1  +  some  fixes,
"enableapic" patch removed).

        Server still work without any problem...

--
Oleg A. Yurlov aka Kris Werewolf, SysAdmin      OAY100-RIPN
mailto:kris@spylog.com                          +7 095 332-03-88

