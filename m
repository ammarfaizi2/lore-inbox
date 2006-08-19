Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751696AbWHSKQZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751696AbWHSKQZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Aug 2006 06:16:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751699AbWHSKQZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Aug 2006 06:16:25 -0400
Received: from 1wt.eu ([62.212.114.60]:34320 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S1751696AbWHSKQY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Aug 2006 06:16:24 -0400
Date: Sat, 19 Aug 2006 12:07:28 +0200
From: Willy Tarreau <w@1wt.eu>
To: Grant Coady <gcoady.lk@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.34-pre1 USB mass-storage burped...
Message-ID: <20060819100728.GA25405@1wt.eu>
References: <9aide2d3ano7v3853kgfhhpbgarmns4t2f@4ax.com> <20060819084724.GA2078@1wt.eu> <78mde2t57okmmnaeslpcen9884mu0v3epb@4ax.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78mde2t57okmmnaeslpcen9884mu0v3epb@4ax.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 19, 2006 at 07:39:06PM +1000, Grant Coady wrote:
> On Sat, 19 Aug 2006 10:47:24 +0200, Willy Tarreau <w@1wt.eu> wrote:
> 
> >Hi Grant,
> >
> >On Sat, Aug 19, 2006 at 06:41:50PM +1000, Grant Coady wrote:
> ...
> >Have you tried building over USB HDD for another kernel (at least 2.4.33) ?
> 
> No.
> 
> >If not, could you give it a try please ? I would like to know if this problem
> >could have been introduced by the locking changes in 2.4.34-pre1.
> 
> Okay, reboot into 2.4.33 and run just the USB HDD test for you, NFS seems 
> okay after 4 hours or so.  I'll leave the USB HDD kernel rebuild running 
> overnight then...

much appreciated, thanks Grant !

Willy

