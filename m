Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310749AbSDUGtE>; Sun, 21 Apr 2002 02:49:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310917AbSDUGtD>; Sun, 21 Apr 2002 02:49:03 -0400
Received: from imladris.infradead.org ([194.205.184.45]:37638 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S310749AbSDUGtC>; Sun, 21 Apr 2002 02:49:02 -0400
Date: Sun, 21 Apr 2002 07:48:58 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Chris Abbey <linux@cabbey.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: possible GPL violation involving linux kernel code
Message-ID: <20020421074858.A8318@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Chris Abbey <linux@cabbey.net>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0204200024030.24652-100000@tweedle.cabbey.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 21, 2002 at 01:43:58AM -0500, Chris Abbey wrote:
> I just know I'm going to regret posting this, but I can think of
> no better group to notify of this than the copyright holders, and
> no better location for the majority of them then l-k.
> 
> While searching through all of the driver images on Promise Tech's
> website I stumbled across their disk images for Caldera/Open Linux
> and their TX2 card ( http://promise.com/support/file/ftol_12014.tgz )
> 
> This tarball contains two disk images:
> -rw-r--r--    1 cabbey    1474560 Nov 19 01:29 ols31-ft.img
> -rw-r--r--    1 cabbey    1474560 Nov 19 01:27 olw31-ft.img
> 
> which in turn contain binary modules from 2.4.2 and 2.4.3
> (intermixed, I found some modules from 2.4.2 and some from
> 2.4.3, as well as a few of their rc's)
> 
> The contents of one of these images (ols31-ft.img) is as such
> (ther other disk is very similar):

Calm down - OpenLinux driver disks are supposed to contain the standard
modules in addition to the new ones.  You can find your sources in
/usr/src/linux.

