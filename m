Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265139AbTBTKvn>; Thu, 20 Feb 2003 05:51:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265140AbTBTKvn>; Thu, 20 Feb 2003 05:51:43 -0500
Received: from 251.017.dsl.syd.iprimus.net.au ([210.50.55.251]:31111 "EHLO
	file1.syd.nuix.com.au") by vger.kernel.org with ESMTP
	id <S265139AbTBTKvl> convert rfc822-to-8bit; Thu, 20 Feb 2003 05:51:41 -0500
Content-Type: text/plain; charset=US-ASCII
From: Song Zhao <song.zhao@nuix.com.au>
Reply-To: song.zhao@nuix.com.au
Organization: Nuix
To: thunder7@xs4all.nl
Subject: Re: Supermicro X5DL8-GG (ServerWorks Grandchampion LE chipset) slow
Date: Thu, 20 Feb 2003 22:01:15 -0500
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
References: <200302202034.28676.song.zhao@nuix.com.au> <20030220102115.GA5217@middle.of.nowhere>
In-Reply-To: <20030220102115.GA5217@middle.of.nowhere>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200302202201.15977.song.zhao@nuix.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Feb 2003 05:21 am, Jurriaan wrote:
> From: Song Zhao <song.zhao@nuix.com.au>
> Date: Thu, Feb 20, 2003 at 08:34:28PM -0500
>
> > Hi,
> >
> > I've been doing some benchmarks with this board, it is terribly
> > disppointing. Has anyone had similar experiences?
>
> How many people do you guess own such hardware? Not me :-(
>
> > The hardware spec is:
> > Dual 2.8GHz Xeon, 3ware Escalade 7850 (7500-8) 12 port IDE RAID
> > controller, RAID 10, 4x 1GB DDR SDRAM Registered ECC, 2x 80GB WD HDD, 10x
> > 120GB WD HDD, ServerWorks Grand Champion LE.
> >
> > I am running RH7.3 with 2.4.20 kernel. The performance of this box is
> > about half of an almost identical box (Supermicro X5DP8-G2 mobo, E7501
> > chipset)
>
> what does
>
> cat /proc/mtrr
>
> say?

sorry I can't tell you right now, as I have just replaced the motherboard with 
another Supermicro mobo, this time a E7500 chipset. As soon as I get it back 
online, I'll let you know. 

>
> > Also, this board can't even boot with 8x 1GB memory modules plugged in (8
> > DIMM slots in total). This is a relative new board and I can't find
> > anything relevant on the net.
>
> "can't boot" as in crashes halfway during linux or doesn't even start
> lilo?

It doesn't even start Lilo, it hangs after it checks memory, 3ware card and 
network card. 

>
> HTH,
> Jurriaan

