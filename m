Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316264AbSEQPkJ>; Fri, 17 May 2002 11:40:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316267AbSEQPkI>; Fri, 17 May 2002 11:40:08 -0400
Received: from roc-24-95-199-137.rochester.rr.com ([24.95.199.137]:32765 "EHLO
	www.kroptech.com") by vger.kernel.org with ESMTP id <S316264AbSEQPkH>;
	Fri, 17 May 2002 11:40:07 -0400
Date: Fri, 17 May 2002 11:40:04 -0400
From: Adam Kropelin <akropel1@rochester.rr.com>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] cpqarray-1: Convert to modern module_init mechanism
Message-ID: <20020517154004.GB27771@www.kroptech.com>
In-Reply-To: <20020517005146.GA32719@www.kroptech.com> <8562.1021610127@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 17, 2002 at 02:35:27PM +1000, Keith Owens wrote:
> On Thu, 16 May 2002 20:51:46 -0400, 
> Adam Kropelin <akropel1@rochester.rr.com> wrote:
> >Below is a patch (against 2.5.15-dj1) to convert cpqarray over to the modern
> >module_init mechanism. This eliminates the need to call cpqarray_init() from
> >genhd.c and starts the process of simplifying the cpqarray init sequence.
> 
> The module related changes look OK, cannot speak for the rest of the
> code changes.

Thanks for your input, Keith.

--Adam
