Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292859AbSBVNLp>; Fri, 22 Feb 2002 08:11:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292860AbSBVNLg>; Fri, 22 Feb 2002 08:11:36 -0500
Received: from ns.ithnet.com ([217.64.64.10]:50181 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S292859AbSBVNLR>;
	Fri, 22 Feb 2002 08:11:17 -0500
Date: Fri, 22 Feb 2002 14:11:01 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Adam Lackorzynski <adam@os.inf.tu-dresden.de>
Cc: fernando@quatro.com.br, linux-kernel@vger.kernel.org
Subject: Re: 2.4.18-rcx: Dual P3 + VIA + APIC
Message-Id: <20020222141101.0cc342e1.skraw@ithnet.com>
In-Reply-To: <20020222130246.GD13774@os.inf.tu-dresden.de>
In-Reply-To: <20020220104129.GP13774@os.inf.tu-dresden.de>
	<051a01c1bb01$70634580$c50016ac@spps.com.br>
	<20020221211142.0cf0efa4.skraw@ithnet.com>
	<20020222130246.GD13774@os.inf.tu-dresden.de>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.7.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Feb 2002 14:02:46 +0100
Adam Lackorzynski <adam@os.inf.tu-dresden.de> wrote:

> On Thu Feb 21, 2002 at 21:11:42 +0100, Stephan von Krawczynski wrote:
> > Hm, interestingly there seem to be more people with via+SMP+somewhat
> > problems. Interestingly, because I cannot confirm these troubles,
> > using such a setup myself. Just have a look:
> 
> > (This is Asus CUV4X-D, dual PIII, and a damn lot of stuff inside :-)
> 
> Same MB here, the lspci output is also the same (for the onboard stuff ;).

Ok, this is fine and makes the comparison at least possible to some extent.

> > I compile my kernel (2.4.18-rc2) with the attached config. Please try
> > it and tell your results. I can assure you that this machine runs rock
> > solid over here for months.
> 
> No luck here. Hangs during boot (tried with 2.4.18-rc2-ac2).

Please start from a setup as close to mine as possible. That is 2.4.18-rc2.
In setup switch MPS 1.4 support to disable and Power Management to disable.

> I even updated the BIOS from 1010 to 1014 as well (just in case). What
> BIOS version are you running? And at how many MHz are the CPUs?

I use BIOS 1010, 2 x P3 1 GHz and tried RAM from 512MB to 2GB. Currently installed are 2GB being 2 x 1GB registered DIMM.

Regards,
Stephan


