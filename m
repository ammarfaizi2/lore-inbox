Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265275AbSKTKSN>; Wed, 20 Nov 2002 05:18:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265249AbSKTKSN>; Wed, 20 Nov 2002 05:18:13 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:39637 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S265275AbSKTKSM>;
	Wed, 20 Nov 2002 05:18:12 -0500
Date: Wed, 20 Nov 2002 11:25:05 +0100
From: Jens Axboe <axboe@suse.de>
To: Robert Love <rml@tech9.net>
Cc: akpm@digeo.com, linux-kernel@vger.kernel.org
Subject: Re: [patch] remove magic numbers in block queue initialization
Message-ID: <20021120102505.GM25830@suse.de>
References: <1037747198.1252.2259.camel@phantasy> <20021120084401.GH11884@suse.de> <1037787670.1254.3140.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1037787670.1254.3140.camel@phantasy>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20 2002, Robert Love wrote:
> On Wed, 2002-11-20 at 03:44, Jens Axboe wrote:
> 
> > No, please leave these alone, testing is on-going in these parts right
> > now.
> 
> Did you look at the patch?  It just pulls the magic numbers out and uses
> defines.  Should make testing easier.

Yes I looked at the patch. Considering that the magic numbers are most
likely going away, it's of no use.

-- 
Jens Axboe

