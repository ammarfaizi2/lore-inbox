Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292856AbSBVNDO>; Fri, 22 Feb 2002 08:03:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292855AbSBVNDG>; Fri, 22 Feb 2002 08:03:06 -0500
Received: from os.inf.tu-dresden.de ([141.76.48.99]:55455 "EHLO
	os.inf.tu-dresden.de") by vger.kernel.org with ESMTP
	id <S292856AbSBVNCv>; Fri, 22 Feb 2002 08:02:51 -0500
Date: Fri, 22 Feb 2002 14:02:46 +0100
From: Adam Lackorzynski <adam@os.inf.tu-dresden.de>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: Fernando Korndorfer <fernando@quatro.com.br>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.18-rcx: Dual P3 + VIA + APIC
Message-ID: <20020222130246.GD13774@os.inf.tu-dresden.de>
Mail-Followup-To: Stephan von Krawczynski <skraw@ithnet.com>,
	Fernando Korndorfer <fernando@quatro.com.br>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020220104129.GP13774@os.inf.tu-dresden.de> <051a01c1bb01$70634580$c50016ac@spps.com.br> <20020221211142.0cf0efa4.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20020221211142.0cf0efa4.skraw@ithnet.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Feb 21, 2002 at 21:11:42 +0100, Stephan von Krawczynski wrote:
> Hm, interestingly there seem to be more people with via+SMP+somewhat
> problems. Interestingly, because I cannot confirm these troubles,
> using such a setup myself. Just have a look:

> (This is Asus CUV4X-D, dual PIII, and a damn lot of stuff inside :-)

Same MB here, the lspci output is also the same (for the onboard stuff ;).

> I compile my kernel (2.4.18-rc2) with the attached config. Please try
> it and tell your results. I can assure you that this machine runs rock
> solid over here for months.

No luck here. Hangs during boot (tried with 2.4.18-rc2-ac2).


I even updated the BIOS from 1010 to 1014 as well (just in case). What
BIOS version are you running? And at how many MHz are the CPUs?



Adam
-- 
Adam                 adam@os.inf.tu-dresden.de
  Lackorzynski         http://a.home.dhs.org
