Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270355AbRHMSHs>; Mon, 13 Aug 2001 14:07:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270359AbRHMSHi>; Mon, 13 Aug 2001 14:07:38 -0400
Received: from [195.63.194.11] ([195.63.194.11]:28174 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S270355AbRHMSH2>; Mon, 13 Aug 2001 14:07:28 -0400
Message-ID: <3B781662.24CE5897@evision-ventures.com>
Date: Mon, 13 Aug 2001 20:03:14 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-12 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Ignacio Vazquez-Abrams <ignacio@openservices.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: memory compress tech...
In-Reply-To: <Pine.LNX.4.33.0108131350000.3127-100000@terbidium.openservices.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ignacio Vazquez-Abrams wrote:
> 
> On Tue, 14 Aug 2001 lkthomas@hkicable.com wrote:
> 
> > another suggestion, mate
> > if you are using dos before, you must know a tools call "QEMM"
> > http://www.netten.net/~garycox/qemm3.htm
> > you can look over this URL if you do not know what is that
> > it can do a real time memory compress and decompress tools ( I mean on fly ), the sound like IBM of MXT..
> > so people can use more memory as they want
> > but IBM one can not compile into kernel :(
> > so I am thinking if someone can program a new code into kernel and let user to select if use it or not
> > ( 8M data in RAM can compress to 4-5M, so people can free up more to use in another side )
> > I hope this one would help for end user :)
> > Thanks
> 
> Here's a text blurb from the page mentioned:
> 
> "Various reports from various reviews that I have seen have indicated Magnaram
> [QEMM's memory compression program] doesn't help very much and in fact can
> really slow down your system. In my tests I found a slight system speed
> decrease and I really couldn't tell if it was helping me any or not... On my
> system I have MagnaRAM turned off. Having enough physical RAM in a system
> ALWAYS outperforms any other way of getting around an insufficent memory
> problem."
> 
> I think he said it best. There may be uses for memory-compression technology,
> but does that make the slow-down worthwhile?

Please read the corresponding research papers by IBM on this
topic. It's all NOT ABOUT RAM size. It is all bout BUS BADWIDTH!
At least if you do it properly - namely in hardware... ;-)
