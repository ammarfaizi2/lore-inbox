Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312358AbSDJKJX>; Wed, 10 Apr 2002 06:09:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312370AbSDJKJW>; Wed, 10 Apr 2002 06:09:22 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:40964 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S312358AbSDJKJV>;
	Wed, 10 Apr 2002 06:09:21 -0400
Date: Wed, 10 Apr 2002 12:09:19 +0200
From: Jens Axboe <axboe@suse.de>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][CFT] IDE TCQ #2
Message-ID: <20020410100919.GH2485@suse.de>
In-Reply-To: <20020409124417.GK25984@suse.de> <3CB3FDF7.6010505@evision-ventures.com> <20020410095829.GG2485@suse.de> <3CB40036.7010504@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10 2002, Martin Dalecki wrote:
> Jens Axboe wrote:
> >On Wed, Apr 10 2002, Martin Dalecki wrote:
> >
> >>Jens Axboe wrote:
> >>
> >>>Hi,
> >>>
> >>>Version 2 is ready. Changes since last time:
> >>
> >>Hi,
> >>
> >>OK I have managed to merge this with the 2.5.8-pre2 + ide-29b at home.
> >>However since we have now apparently already a -pre3 I will have
> >>to at least redo the patches against it. If this takes more
> >>then the time needed for a cup of coffe I will have unfortuntely to
> >>do it today afternoon.
> >
> >
> >I'm already running 2.5.8-pre3 (which appears to include ide-29b,
> >right?) + ide-tcq here, so you should probably not waste any effort on
> >that :-)
> 
> Well than I will have to basically redo all the
> stuff I did in between... like for example nuking the
> number of parameters to ata_taskfile()... :-(.

Ok, go ahead with the merge then and keep your changes. I'll just diff
#2 -> current and apply that to whatever shows up in the next kernel.

-- 
Jens Axboe

