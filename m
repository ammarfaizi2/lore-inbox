Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314584AbSGYPZS>; Thu, 25 Jul 2002 11:25:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314811AbSGYPZS>; Thu, 25 Jul 2002 11:25:18 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:16539 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S314584AbSGYPZR>;
	Thu, 25 Jul 2002 11:25:17 -0400
Date: Thu, 25 Jul 2002 17:28:18 +0200
From: Jens Axboe <axboe@suse.de>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: "KOCHI, Takayoshi" <t-kouchi@mvf.biglobe.ne.jp>,
       linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Subject: Re: [PATCH] aic7xxx driver doesn't release region
Message-ID: <20020725152818.GD23832@suse.de>
References: <20020725145847.GC23832@suse.de> <200207251524.g6PFONbA048949@aslan.scsiguy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200207251524.g6PFONbA048949@aslan.scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25 2002, Justin T. Gibbs wrote:
> >> Unfortunately, I haven't had any spare time to play with 2.5.  I have
> >> faithfully maintained the 2.4 driver and will look at 2.5 once the
> >> time to do so presents itself.
> >
> >So you have no problem with me updating 2.5 aic7xxx to match 2.4
> >current?
> 
> Did you ask when you did the first port? 8-)

In all fairness, the first port _had_ to be done from my point of view
since I needed _something_ to test the changes on. And to defend myself
even further, I didn't have time to ask maintainers permission before
Linus pulled the changes in.

I can probably come up with a handful more reasons if needed :-)

> In otherwords... be my guest.

Cool, thanks.

-- 
Jens Axboe

