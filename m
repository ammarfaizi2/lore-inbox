Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313477AbSGIKtF>; Tue, 9 Jul 2002 06:49:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313563AbSGIKtE>; Tue, 9 Jul 2002 06:49:04 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:54432 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S313477AbSGIKtB>;
	Tue, 9 Jul 2002 06:49:01 -0400
Date: Tue, 9 Jul 2002 12:51:35 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Jens Axboe <axboe@suse.de>
Cc: Anton Altaparmakov <aia21@cantab.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org
Subject: Re: [PATCH] 2.4 IDE core for 2.5
Message-ID: <20020709125135.A7885@ucw.cz>
References: <20020709102249.GA20870@suse.de> <Pine.SOL.3.96.1020709114618.20865B-100000@libra.cus.cam.ac.uk> <20020709104935.GB20870@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020709104935.GB20870@suse.de>; from axboe@suse.de on Tue, Jul 09, 2002 at 12:49:35PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 09, 2002 at 12:49:35PM +0200, Jens Axboe wrote:

> On Tue, Jul 09 2002, Anton Altaparmakov wrote:
> > On Tue, 9 Jul 2002, Jens Axboe wrote:
> > > I've forward ported the 2.4 IDE core (well 2.4.19-pre10-ac2 to be exact)
> > > to 2.5.25. It consists of 7 separate patches:
> > 
> > Fantastic! Seeing that the patches are bitkeeper generated, would it be
> > possible for you to make a repository available with the patches? (on
> > bkbits perhaps?) Would make it a lot easier for us bitkeeper users just to
> > pull from your repository... Especially once you update the patches...
> 
> Yes they are from a bk tree here, I'll set one up on bkbits...

Cool, thanks. I guess I also will make a lot of use of those patches.
I need to be debugging input now, not IDE. ;) 

-- 
Vojtech Pavlik
SuSE Labs
