Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315461AbSFOSvc>; Sat, 15 Jun 2002 14:51:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315463AbSFOSvb>; Sat, 15 Jun 2002 14:51:31 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:985 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S315461AbSFOSva>;
	Sat, 15 Jun 2002 14:51:30 -0400
Date: Sat, 15 Jun 2002 20:51:28 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Anssi Saari <as@sci.fi>
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux 2.4.19-preX IDE bugs
Message-ID: <20020615205128.A17996@ucw.cz>
In-Reply-To: <20020615171246.GB22017@sci.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 15, 2002 at 08:12:47PM +0300, Anssi Saari wrote:
> On Fri, 14 Jun 2002, Andre Hedrick wrote: 
> 
> > http://www.tecchannel.de/hardware/817/index.html
> > 
> > Read about the JUNK hardware base you are working with.
> > This is one of the reasons people avoid VIA. 
> 
> Do you have recommendations for chipsets for AMD CPUs, especially from
> Linux IDE driver guy's point of view and especially regarding Linux
> support for them? ALi, AMD, nVidia or SiS?
> 
> It seems hard to find any comparisons between current VIA and non-VIA
> motherboards on the net. 

ALi: don't know.
AMD: Works fine. UDMA100 max. I like these best.
nVidia: Only in 2.5 kernels.
SiS: don't know.
VIA: Works fine. If you're unlucky and get a bad board, then, well,
	you're unlucky. Currently the fastest Athlon solution.

-- 
Vojtech Pavlik
SuSE Labs
