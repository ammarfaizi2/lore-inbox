Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130512AbRBKWI0>; Sun, 11 Feb 2001 17:08:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130600AbRBKWIQ>; Sun, 11 Feb 2001 17:08:16 -0500
Received: from clueserver.org ([206.163.47.224]:2310 "HELO clueserver.org")
	by vger.kernel.org with SMTP id <S130512AbRBKWII>;
	Sun, 11 Feb 2001 17:08:08 -0500
Date: Sun, 11 Feb 2001 14:19:50 -0800 (PST)
From: Alan Olsen <alan@clueserver.org>
To: Jens Axboe <axboe@suse.de>
Cc: Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org,
        Rogerio Brito <rbrito@iname.com>
Subject: Re: Slowing down CDROM drives (was: Re: ATAPI CDRW which doesn't
 work)
In-Reply-To: <20010211223817.M16362@suse.de>
Message-ID: <Pine.LNX.4.10.10102111419110.22754-100000@clueserver.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Sorry. it was late when I answered that.  (Either that or no ocffe, not
certain which.)

On Sun, 11 Feb 2001, Jens Axboe wrote:

> On Sun, Feb 11 2001, Alan Olsen wrote:
> > > It's no news that vendors only implement what they want to. New
> > > cd-r/w and dvd drives are not required to implement this command,
> > > so it may not work there either.
> > 
> > Take a look at the code for cdparanoia or one of the other MP3 ripping
> > programms. Slowing down the drive is a standard feature for that type of
> > program.  (Reduces errors when pulling audio tracks off the disc.)
> 
> One would think that you have taken a look at the cdparanoia
> source before posting something like this. Guess what it does to
> control speed? Reread my message, you totally missed the point.
> 
> -- 
> Jens Axboe
> 
> 

alan@ctrl-alt-del.com | Note to AOL users: for a quick shortcut to reply
Alan Olsen            | to my mail, just hit the ctrl, alt and del keys.
    "In the future, everything will have its 15 minutes of blame."

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
