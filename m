Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315277AbSGYPoR>; Thu, 25 Jul 2002 11:44:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315337AbSGYPoR>; Thu, 25 Jul 2002 11:44:17 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:58780 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S315277AbSGYPoQ>;
	Thu, 25 Jul 2002 11:44:16 -0400
Date: Thu, 25 Jul 2002 17:47:16 +0200
From: Jens Axboe <axboe@suse.de>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: "KOCHI, Takayoshi" <t-kouchi@mvf.biglobe.ne.jp>,
       linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Subject: Re: [PATCH] aic7xxx driver doesn't release region
Message-ID: <20020725154716.GE23832@suse.de>
References: <20020725152818.GD23832@suse.de> <200207251531.g6PFVxbA049156@aslan.scsiguy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200207251531.g6PFVxbA049156@aslan.scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25 2002, Justin T. Gibbs wrote:
> >> Did you ask when you did the first port? 8-)
> >
> >In all fairness, the first port _had_ to be done from my point of view
> >since I needed _something_ to test the changes on. And to defend myself
> >even further, I didn't have time to ask maintainers permission before
> >Linus pulled the changes in.
> >
> >I can probably come up with a handful more reasons if needed :-)
> 
> This is opensource.  Once the code goes out, I have limited control
> over what people do with it.  This is by design and expected.  There's
> no need to defend yourself since you didn't do anything wrong.

Well in theory you are right. But I always like to pass changes on to
the maintainer for submission, and I expect others to do likewise. The
maintainer usually has the better grasp of the code and can make the
better call on what to include, reject, etc. Even though it's open
source it doesn't have to be anarchy.

-- 
Jens Axboe

