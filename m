Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285692AbSBZWqv>; Tue, 26 Feb 2002 17:46:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285850AbSBZWqi>; Tue, 26 Feb 2002 17:46:38 -0500
Received: from dsl-213-023-039-032.arcor-ip.net ([213.23.39.32]:23949 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S284180AbSBZWqS>;
	Tue, 26 Feb 2002 17:46:18 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Steve Lord <lord@sgi.com>, Andreas Dilger <adilger@turbolabs.com>
Subject: Re: Congrats Marcelo,
Date: Mon, 25 Feb 2002 00:39:36 +0100
X-Mailer: KMail [version 1.3.2]
Cc: "Dennis, Jim" <jdennis@snapserver.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
In-Reply-To: <2D0AFEFEE711D611923E009027D39F2B153AD4@cdserv.meridian-data.com> <20020226140644.U12832@lynx.adilger.int> <1014760581.5993.159.camel@jen.americas.sgi.com>
In-Reply-To: <1014760581.5993.159.camel@jen.americas.sgi.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16f8Ey-0002qn-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On February 26, 2002 10:56 pm, Steve Lord wrote:
> On Tue, 2002-02-26 at 15:06, Andreas Dilger wrote:
> > On Feb 26, 2002  12:38 -0800, Dennis, Jim wrote:
> > >  Now I need to know about the status of several unofficial patches:
> > 
> > While my word is by no means official, my general understanding is:
> > 
> > > 	XFS
> > 
> > Not for 2.4 - just too many changes to the core kernel code.
> 
> Someone has got to kill this assumption people have about XFS, it
> makes much smaller changes than some things which have gone in,
> the odd VM rewrite here and there to name some. Given that we now
> have official EA system calls, the last chunk of stuff to resolve
> is quota. This is being worked on with Jan Kara.

I'd really like to see XFS go in, but don't you think 2.5 is the place,
with a view to 2.4 submission in due course?

As far as making the case goes, do you have time to make a list of
places where XFS goes outside fs/xfs, and why?

-- 
Daniel
