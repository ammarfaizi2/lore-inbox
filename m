Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292865AbSBVN5O>; Fri, 22 Feb 2002 08:57:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292866AbSBVN5D>; Fri, 22 Feb 2002 08:57:03 -0500
Received: from [200.180.163.180] ([200.180.163.180]:31300 "EHLO quatroint")
	by vger.kernel.org with ESMTP id <S292865AbSBVN4y>;
	Fri, 22 Feb 2002 08:56:54 -0500
Message-ID: <004801c1bba8$831250c0$c50016ac@spps.com.br>
Reply-To: "Fernando Korndorfer" <fernando@quatro.com.br>
From: "Fernando Korndorfer" <fernando@quatro.com.br>
To: "Stephan von Krawczynski" <skraw@ithnet.com>
Cc: "Adam Lackorzynski" <adam@os.inf.tu-dresden.de>,
        "LKML" <linux-kernel@vger.kernel.org>
In-Reply-To: <20020220104129.GP13774@os.inf.tu-dresden.de><051a01c1bb01$70634580$c50016ac@spps.com.br><20020221211142.0cf0efa4.skraw@ithnet.com><20020222130246.GD13774@os.inf.tu-dresden.de> <20020222141101.0cc342e1.skraw@ithnet.com>
Subject: Re: 2.4.18-rcx: Dual P3 + VIA + APIC
Date: Fri, 22 Feb 2002 10:54:55 -0300
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Adam Lackorzynski <adam@os.inf.tu-dresden.de> wrote:
>
> > Same MB here, the lspci output is also the same (for the onboard stuff
;).
>
> Ok, this is fine and makes the comparison at least possible to some
extent.

> Please start from a setup as close to mine as possible. That is
2.4.18-rc2.
> In setup switch MPS 1.4 support to disable and Power Management to
disable.
>
> > I even updated the BIOS from 1010 to 1014 as well (just in case). What
> > BIOS version are you running? And at how many MHz are the CPUs?
>
> I use BIOS 1010, 2 x P3 1 GHz and tried RAM from 512MB to 2GB. Currently
installed are 2GB being 2 x 1GB registered DIMM.

    The MB is the same for me (I guess). The machine is about 60Km distant
from me now, so I have not compiled with your .config yet. Next time I'll
try to gather some info for the list. The lspci is almost the same.




-----------------------------------------------
Fernando Korndorfer
Novo Hamburgo, RS, Brasil
-----------------------------------------------


