Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132504AbRCZRsX>; Mon, 26 Mar 2001 12:48:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132503AbRCZRsO>; Mon, 26 Mar 2001 12:48:14 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:8720
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S132504AbRCZRr7>; Mon, 26 Mar 2001 12:47:59 -0500
Date: Mon, 26 Mar 2001 09:46:54 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: "Zephaniah E. Hull" <warp@whitestar.soark.net>
cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Lovely crash with 2.4.2-ac24.
In-Reply-To: <20010326121747.A3920@whitestar.soark.net>
Message-ID: <Pine.LNX.4.10.10103260944170.12547-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Zephaniah,

Does this happen in a non-ac kernel?
I have not updated code since around 2.4.0, but other have.
You point ot a few times w/ ac18, but is there one before that which does
not cause this to happen?

The question is to gain isolation of the changes.

On Mon, 26 Mar 2001, Zephaniah E. Hull wrote:

> This had hit me a few times with ac18 (I'm not sure it was the same
> crash though) and just hit me again with ac24.
> 
> Alan cced due to it being in the ac kernels, Andre because the trace
> seems to point to the IDE code.
> 
> Thanks.
> 
> Zephaniah E. Hull.
> 
> -- 
>  PGP EA5198D1-Zephaniah E. Hull <warp@whitestar.soark.net>-GPG E65A7801
>     Keys available at http://whitestar.soark.net/~warp/public_keys.
>            CCs of replies from mailing lists are encouraged.
> 
> <cas> Mercury: gpm isn't a very good web browser.  fix it.
> 

Andre Hedrick
Linux ATA Development
ASL Kernel Development
-----------------------------------------------------------------------------
ASL, Inc.                                     Toll free: 1-877-ASL-3535
1757 Houret Court                             Fax: 1-408-941-2071
Milpitas, CA 95035                            Web: www.aslab.com

