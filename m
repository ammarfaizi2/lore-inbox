Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270339AbRHMRx0>; Mon, 13 Aug 2001 13:53:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270343AbRHMRxR>; Mon, 13 Aug 2001 13:53:17 -0400
Received: from [209.202.108.240] ([209.202.108.240]:23568 "EHLO
	terbidium.openservices.net") by vger.kernel.org with ESMTP
	id <S270339AbRHMRxG>; Mon, 13 Aug 2001 13:53:06 -0400
Date: Mon, 13 Aug 2001 13:53:06 -0400 (EDT)
From: Ignacio Vazquez-Abrams <ignacio@openservices.net>
To: <linux-kernel@vger.kernel.org>
Subject: Re: memory compress tech...
In-Reply-To: <200108131744.BAA27539@alto.i-cable.com>
Message-ID: <Pine.LNX.4.33.0108131350000.3127-100000@terbidium.openservices.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-scanner: scanned by Inflex 1.0.7 - (http://pldaniels.com/inflex/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Aug 2001 lkthomas@hkicable.com wrote:

> another suggestion, mate
> if you are using dos before, you must know a tools call "QEMM"
> http://www.netten.net/~garycox/qemm3.htm
> you can look over this URL if you do not know what is that
> it can do a real time memory compress and decompress tools ( I mean on fly ), the sound like IBM of MXT..
> so people can use more memory as they want
> but IBM one can not compile into kernel :(
> so I am thinking if someone can program a new code into kernel and let user to select if use it or not
> ( 8M data in RAM can compress to 4-5M, so people can free up more to use in another side )
> I hope this one would help for end user :)
> Thanks

Here's a text blurb from the page mentioned:

"Various reports from various reviews that I have seen have indicated Magnaram
[QEMM's memory compression program] doesn't help very much and in fact can
really slow down your system. In my tests I found a slight system speed
decrease and I really couldn't tell if it was helping me any or not... On my
system I have MagnaRAM turned off. Having enough physical RAM in a system
ALWAYS outperforms any other way of getting around an insufficent memory
problem."

I think he said it best. There may be uses for memory-compression technology,
but does that make the slow-down worthwhile?

-- 
Ignacio Vazquez-Abrams  <ignacio@openservices.net>

