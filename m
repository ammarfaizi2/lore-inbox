Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289888AbSAPJG0>; Wed, 16 Jan 2002 04:06:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289891AbSAPJGQ>; Wed, 16 Jan 2002 04:06:16 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:14867 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S289888AbSAPJGC>;
	Wed, 16 Jan 2002 04:06:02 -0500
Date: Wed, 16 Jan 2002 10:05:40 +0100
From: Jens Axboe <axboe@suse.de>
To: Andrew Ebling <aebling@tao-group.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CDRW packet writing status
Message-ID: <20020116100540.J3805@suse.de>
In-Reply-To: <1011171090.389.19.camel@spinel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1011171090.389.19.camel@spinel>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16 2002, Andrew Ebling wrote:
> Hi Jens, (and fellow kernel hackers)
> 
> Please can you advise of the current status of CDRW packet writing
> status?
> 
> The latest version I can find is 0.0.2o-pre1, against 2.4.7.
> 
> Is there any possibility of bringing it up to date with 2.4.x in the
> near future?
> 
> If no new release is imminent, I _may_ have a go at bringing the patch
> up to date, but this will depend on how much has changed in affected
> areas.  (i.e. I'll probably succeed if just trivial changes are
> involved.)

If you follow the packet-writing list, you'll see that Peter Osterlund
has been regularly updating the patch and adding fixes. There are
patches for 2.4.18-latest.

-- 
Jens Axboe

