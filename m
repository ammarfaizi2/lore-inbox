Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313508AbSGYNSZ>; Thu, 25 Jul 2002 09:18:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313477AbSGYNSZ>; Thu, 25 Jul 2002 09:18:25 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:39564 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S313508AbSGYNSX>;
	Thu, 25 Jul 2002 09:18:23 -0400
Date: Thu, 25 Jul 2002 15:21:18 +0200
From: Jens Axboe <axboe@suse.de>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: "KOCHI, Takayoshi" <t-kouchi@mvf.biglobe.ne.jp>,
       linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Subject: Re: [PATCH] aic7xxx driver doesn't release region
Message-ID: <20020725132118.GB8761@suse.de>
References: <20020724132119.2803.T-KOUCHI@mvf.biglobe.ne.jp> <200207242228.g6OMSmbA040560@aslan.scsiguy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200207242228.g6OMSmbA040560@aslan.scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24 2002, Justin T. Gibbs wrote:
> >Hi,
> >
> >This is a patch to fix releasing memory and io regions for the
> >aic7xxx driver.  This applies both 2.4- and 2.5-series.
> 
> I don't recall when exactly this was fixed in the aic7xxx driver,
> but probably 6.2.5 or so.  The 2.5.X kernel must not be using
> a recent version of the driver.  Marcelo's tree has 6.2.8

You make it sounds as if someone would be updating it for you. The
version that is in 2.5 is the version that you last updated it to, end
of story.

I've offered to update the 2.5 version before, without much luck. I'll
do the same again.

-- 
Jens Axboe

