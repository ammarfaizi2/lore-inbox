Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315457AbSGYOzs>; Thu, 25 Jul 2002 10:55:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315539AbSGYOzs>; Thu, 25 Jul 2002 10:55:48 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:51864 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S315457AbSGYOzq>;
	Thu, 25 Jul 2002 10:55:46 -0400
Date: Thu, 25 Jul 2002 16:58:47 +0200
From: Jens Axboe <axboe@suse.de>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: "KOCHI, Takayoshi" <t-kouchi@mvf.biglobe.ne.jp>,
       linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Subject: Re: [PATCH] aic7xxx driver doesn't release region
Message-ID: <20020725145847.GC23832@suse.de>
References: <20020725132118.GB8761@suse.de> <200207251455.g6PEtvbA048548@aslan.scsiguy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200207251455.g6PEtvbA048548@aslan.scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25 2002, Justin T. Gibbs wrote:
> >> I don't recall when exactly this was fixed in the aic7xxx driver,
> >> but probably 6.2.5 or so.  The 2.5.X kernel must not be using
> >> a recent version of the driver.  Marcelo's tree has 6.2.8
> >
> >You make it sounds as if someone would be updating it for you. The
> >version that is in 2.5 is the version that you last updated it to, end
> >of story.
> 
> You make it sound like I have ever done any developement for 2.5.  I
> haven't.  Someone else did the port of the aic7xxx to 2.5.  End of
> story. 8-)

Heh yes I know, oh and I did the 2.5 "port" (it wasn't much of a port at
that point, but aic7xxx was one of my bio test victims) :-)

> Unfortunately, I haven't had any spare time to play with 2.5.  I have
> faithfully maintained the 2.4 driver and will look at 2.5 once the
> time to do so presents itself.

So you have no problem with me updating 2.5 aic7xxx to match 2.4
current?

-- 
Jens Axboe

