Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317833AbSIERtY>; Thu, 5 Sep 2002 13:49:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317946AbSIERtY>; Thu, 5 Sep 2002 13:49:24 -0400
Received: from acd.ufrj.br ([146.164.3.7]:58376 "EHLO acd.ufrj.br")
	by vger.kernel.org with ESMTP id <S317833AbSIERtY>;
	Thu, 5 Sep 2002 13:49:24 -0400
Content-Type: text/plain; charset=US-ASCII
From: Scorpion <scorpionlab@ieg.com.br>
Reply-To: scorpionlab@ieg.com.br
Organization: ScorpionLAB
To: linux-kernel@vger.kernel.org
Subject: Re: IO-APIC in SMP dual Athlon XP1800
Date: Thu, 5 Sep 2002 14:53:54 -0300
User-Agent: KMail/1.4.1
References: <Pine.LNX.4.44.0207292151420.20701-100000@linux-box.realnet.co.sz>
In-Reply-To: <Pine.LNX.4.44.0207292151420.20701-100000@linux-box.realnet.co.sz>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200209051453.54728.scorpionlab@ieg.com.br>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,
I got my Dual Athlon XP1800 working now. 
Everything gonna well after changed MP 1.4 Support to disable in BIOS, and 
leaving MP table enabled.
Anyone knows if linux 2.4.19 has not yet a full implemantation of MP 1.4 or if 
it is just a BIOSes bug?

Thanks in advance,
Scorpion.

On Monday 29 July 2002 16:52, The Kernel Developer Zwane Mwaikambo wrote:
> On Mon, 29 Jul 2002, Scorpion wrote:
> > I'm getting in troubles with a A7M266-D motherboard with two
> > Athlon XP 1800 cpus (yes, XP not MP!).
>
> Which kernel version ?
>
> 	Zwane

