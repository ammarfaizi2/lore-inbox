Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135931AbREJAfd>; Wed, 9 May 2001 20:35:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135939AbREJAfY>; Wed, 9 May 2001 20:35:24 -0400
Received: from mail.intrex.net ([209.42.192.246]:32017 "EHLO intrex.net")
	by vger.kernel.org with ESMTP id <S135931AbREJAfN>;
	Wed, 9 May 2001 20:35:13 -0400
Date: Wed, 9 May 2001 20:36:08 -0400
From: jlnance@intrex.net
To: linux-kernel@vger.kernel.org
Subject: Re: reiserfs, xfs, ext2, ext3
Message-ID: <20010509203608.A30613@bessie.localdomain>
In-Reply-To: <01051001124700.06492@starship> <Pine.LNX.4.30.0105091619220.17823-100000@anime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.30.0105091619220.17823-100000@anime.net>; from goemon@anime.net on Wed, May 09, 2001 at 04:19:53PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 09, 2001 at 04:19:53PM -0700, Dan Hollis wrote:
> On Thu, 10 May 2001, Daniel Phillips wrote:
> > It would be great to see a table of ReiserFS/XFS/Ext2+index performance
> > results.  Well, to make it really fair it should be Ext3+index so I'd
> > better add 'backport the patch to 2.2' or 'bug Stephen and friends to
> > hurry up' to my to-do list.
> 
> Is the IBM JFS at a testable state yet, or is it still 'bleedin beta'?

It is not stable enough to use in production yet.  It is certainly stable
enough to test/benchmark.  They released a new patch today which is supposed
to fix a long standing deadlock, so thats good news.  Give it a shot.

Jim
