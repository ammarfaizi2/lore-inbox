Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315419AbSHKRzU>; Sun, 11 Aug 2002 13:55:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315805AbSHKRzU>; Sun, 11 Aug 2002 13:55:20 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:17166 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315419AbSHKRzT>;
	Sun, 11 Aug 2002 13:55:19 -0400
Message-ID: <3D56A83E.ECF747C6@zip.com.au>
Date: Sun, 11 Aug 2002 11:09:02 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Adam Kropelin <akropel1@rochester.rr.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 1/21] random fixes
References: <3D56146B.C3CAB5E1@zip.com.au> <20020811142938.GA681@www.kroptech.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam Kropelin wrote:
> 
> On Sun, Aug 11, 2002 at 12:38:19AM -0700, Andrew Morton wrote:
> > Sorry, but there's a ton of stuff here.  It ends up as a 4600 line
> > diff.  Some code dating back to 2.5.24.  It's almost all performance
> 
> Andrew,
> 
> Nearly all the patches against mm/vmscan.c are failing when applied
> to the 2.5.31 Linus just released. Are these patches against a
> slightly older BK rev?

Gee I hope not.

Try getting them from http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.31/,
or the big rollup http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.31/everything.gz
