Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291886AbSBNUud>; Thu, 14 Feb 2002 15:50:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291882AbSBNUuY>; Thu, 14 Feb 2002 15:50:24 -0500
Received: from smtp3.vol.cz ([195.250.128.83]:42512 "EHLO smtp3.vol.cz")
	by vger.kernel.org with ESMTP id <S291885AbSBNUuO>;
	Thu, 14 Feb 2002 15:50:14 -0500
Date: Thu, 14 Feb 2002 09:40:47 +0000
From: Pavel Machek <pavel@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Jens Axboe <axboe@suse.de>, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: IDE cleanup for 2.5.4-pre3
Message-ID: <20020214094046.B37@toy.ucw.cz>
In-Reply-To: <20020208231346.GA1209@elf.ucw.cz> <20020211094230.E1957@suse.de> <20020211134443.GC20854@atrey.karlin.mff.cuni.cz> <20020211181013.K729@suse.de> <20020213225326.A10409@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20020213225326.A10409@suse.cz>; from vojtech@suse.cz on Wed, Feb 13, 2002 at 10:53:26PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > > Here are first small ide cleanups. Jens, please apply,
> > > > 
> > > > Looks good to me.
> > > 
> > > Is it "Looks good to me, applied", or "Looks good to me, good luck
> > > pushing it to Linus?" :-).
> > 
> > As in I've applied it to my tree, it should find it's way upwards :-)
> 
> Here is another version of the patch, doing more extensive cleanups of
> unnecessary casts, unnecessary assignments and (void *) pointers where
> typed pointers should be.

Looks good to me.
								Pavel

-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

