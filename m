Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129320AbRBKVjR>; Sun, 11 Feb 2001 16:39:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129766AbRBKVjI>; Sun, 11 Feb 2001 16:39:08 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:54542 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S129320AbRBKViw>;
	Sun, 11 Feb 2001 16:38:52 -0500
Date: Sun, 11 Feb 2001 22:38:17 +0100
From: Jens Axboe <axboe@suse.de>
To: Alan Olsen <alan@clueserver.org>
Cc: Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org,
        Rogerio Brito <rbrito@iname.com>
Subject: Re: Slowing down CDROM drives (was: Re: ATAPI CDRW which doesn't work)
Message-ID: <20010211223817.M16362@suse.de>
In-Reply-To: <20010211174707.I16362@suse.de> <Pine.LNX.4.10.10102111220160.22754-100000@clueserver.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10102111220160.22754-100000@clueserver.org>; from alan@clueserver.org on Sun, Feb 11, 2001 at 12:21:43PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 11 2001, Alan Olsen wrote:
> > It's no news that vendors only implement what they want to. New
> > cd-r/w and dvd drives are not required to implement this command,
> > so it may not work there either.
> 
> Take a look at the code for cdparanoia or one of the other MP3 ripping
> programms. Slowing down the drive is a standard feature for that type of
> program.  (Reduces errors when pulling audio tracks off the disc.)

One would think that you have taken a look at the cdparanoia
source before posting something like this. Guess what it does to
control speed? Reread my message, you totally missed the point.

-- 
Jens Axboe

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
