Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319369AbSHQIWI>; Sat, 17 Aug 2002 04:22:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319370AbSHQIWI>; Sat, 17 Aug 2002 04:22:08 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:10161 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S319369AbSHQIWH>;
	Sat, 17 Aug 2002 04:22:07 -0400
Date: Sat, 17 Aug 2002 10:25:40 +0200
From: Jens Axboe <axboe@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Anton Altaparmakov <aia21@cantab.net>, alan@lxorguk.ukuu.org,
       andre@linux-ide.org, vojtech@suse.cz, bkz@linux-ide.org,
       linux-kernel@vger.kernel.org
Subject: Re: IDE?
Message-ID: <20020817082540.GP11044@suse.de>
References: <Pine.SOL.3.96.1020817004411.25629B-100000@draco.cus.cam.ac.uk> <Pine.LNX.4.44.0208161706390.1674-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0208161706390.1674-100000@home.transmeta.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16 2002, Linus Torvalds wrote:
> 
> On Sat, 17 Aug 2002, Anton Altaparmakov wrote:
> > 
> > Out of curiosity, who is going to be IDE 2.5 kernel maintainer now?
> 
> Well, as I implied, Alan seems to be not completely unwilling to work on 
> it, and unlike me he _can_ interact with Andre most of the time. Possibly 
> Jens will do the 2.5.x side, of it (with Alan working on 2.4), but we've 
> not talked it through.

I'd never want to be the maintainer, but I do not mind taking care of
2.5 ide in the sense that 2.4-ac (or whatever) gets adapted, split to
digestible pieces (Andre's stuff always appears in big globs) and pushed
upstream.

> I'd like Vojtech to be a bit involved too, he seemed to do some
> much-needed cleanups for PIIX4 IDE (now gone, since we couldn't save just
> those parts..)

Me too. And Bartlomiej too, for that matter.

-- 
Jens Axboe

