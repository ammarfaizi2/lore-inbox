Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030414AbVIVPry@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030414AbVIVPry (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 11:47:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030413AbVIVPry
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 11:47:54 -0400
Received: from xenotime.net ([66.160.160.81]:44209 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1030414AbVIVPrx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 11:47:53 -0400
Date: Thu, 22 Sep 2005 08:47:52 -0700 (PDT)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: David R <david@industrialstrengthsolutions.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: DMA broken in mainline 2.6.13.2 _AND_ opensuse vendor 2.6.13-15
 - oopsers
In-Reply-To: <4332CB66.7090107@industrialstrengthsolutions.com>
Message-ID: <Pine.LNX.4.58.0509220846070.20059@shark.he.net>
References: <433216C2.4020707@industrialstrengthsolutions.com>
 <1127398965.18840.88.camel@localhost.localdomain>
 <4332CB66.7090107@industrialstrengthsolutions.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Sep 2005, David R wrote:

>
> >
> >
> >>DMA is broken in 2.6.13.2 and opensuse 2.6.13-15, for  my  cdrom/dvd
> >>
> >>
> >
> >particular that you turned off IDE PCI
> >
> >
> You are totaly correct and I apologize for that, the last thing I want
> to do is increase the noise level.  I spent several hours trying to get
> netconsole to work with this, but I spose it just happens to soon. Im
> getting an oops now. (The oops was happening a week or so ago when I
> first tried to upgrade from .12 to .13 by simply using make oldconfig
> and going from there, then I started poking around and eventualy the
> drive worked but with no dma)  Attached is my current oops generating
> config. Here is a digicam shot of my screen:
>

if you can't use serial console or netconsole, can you use a
smaller screen font so that we can see more oops info?
that screen shot is missing a good bit of info.

>
> Again my drive is a:
>
> LITE-ON DVDRW SOHW-1693S, FwRev=KS09
>
> And my IDE chip is a:
> VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C/VT8235 PIPC Bus Master IDE (rev 06)
>
> Thanks!
>
> -David
>
> ps. Your beard rocks!

-- 
~Randy
