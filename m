Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266005AbUAEXd4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 18:33:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266019AbUAEXdz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 18:33:55 -0500
Received: from intra.cyclades.com ([64.186.161.6]:6842 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S266005AbUAEXcF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 18:32:05 -0500
Date: Mon, 5 Jan 2004 21:15:18 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Lukasz Trabinski <lukasz@wsisiz.edu.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.24-rc1
In-Reply-To: <Pine.LNX.4.58LT.0401052156570.1448@lt.wsisiz.edu.pl>
Message-ID: <Pine.LNX.4.58L.0401052105460.5618@logos.cnet>
References: <Pine.LNX.4.58L.0401051130250.1188@logos.cnet>
 <200401051744.i05HiJI1005152@lt.wsisiz.edu.pl> <20040105182117.GZ1882@matchmail.com>
 <Pine.LNX.4.58LT.0401052156570.1448@lt.wsisiz.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 5 Jan 2004, Lukasz Trabinski wrote:

> On Mon, 5 Jan 2004, Mike Fedyk wrote:
> > > > The 2.4.24-pre tree with all its modifications becomes 2.4.25-pre.
> > >
> > > When we can expect 2.4.25-pre?
> >
> > Probably when marcelo thinks there are enough changes to make another -pre
> > release.
> >
> > Now the real question is will it be 2.4.25-pre4 or 2.4.25-pre1? ;)
>
> I have asked because on one machine (with heavy load) i have problems
> with 2.4.23 and 2.4.24-pre* - crashes without any information (no oops)
> in logs file or console (connected via RS). Only blank screen. Sync or
> umount via SysRq  doesn't work, only (re)boot. System is RH 9, ext3
> 2x2.66GHz (with HT), aic79xx, 4GB RAM +4GB swap.

Hi Lukasz,

Which kernels work on this box?

Have you tried any other 2.4.x or 2.6.x ?
