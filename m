Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286336AbRLJRp7>; Mon, 10 Dec 2001 12:45:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286337AbRLJRps>; Mon, 10 Dec 2001 12:45:48 -0500
Received: from mpdr0.detroit.mi.ameritech.net ([206.141.239.206]:15328 "EHLO
	mailhost.det.ameritech.net") by vger.kernel.org with ESMTP
	id <S286336AbRLJRph>; Mon, 10 Dec 2001 12:45:37 -0500
Date: Mon, 10 Dec 2001 12:43:45 -0500 (EST)
From: volodya@mindspring.com
Reply-To: volodya@mindspring.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: mm question
In-Reply-To: <E16DUaV-0002mw-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.20.0112101242410.18043-100000@node2.localnet.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 10 Dec 2001, Alan Cox wrote:

> > Yes, but agpgart will not let more then one driver use it. So it will be
> > _either_ 3d or video capture with switching upon Xserver restart. Sucks !
> 
> That sounds like agpgart needs fixing. Its going to be easier than hacking
> the vm code
> 

Well, I was trying to avoid that and simply distribute additional memory
management routines with the driver. 

                     Vladimir Dergachev

