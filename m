Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318807AbSHQAD2>; Fri, 16 Aug 2002 20:03:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318841AbSHQAD2>; Fri, 16 Aug 2002 20:03:28 -0400
Received: from draco.cus.cam.ac.uk ([131.111.8.18]:46740 "EHLO
	draco.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S318807AbSHQAD1>; Fri, 16 Aug 2002 20:03:27 -0400
Date: Sat, 17 Aug 2002 01:07:19 +0100 (BST)
From: Anton Altaparmakov <aia21@cantab.net>
Reply-To: Anton Altaparmakov <aia21@cantab.net>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, andre@linux-ide.org, axboe@suse.de,
       bkz@linux-ide.org, linux-kernel@vger.kernel.org
Subject: Re: IDE?
In-Reply-To: <Pine.SOL.3.96.1020817004411.25629B-100000@draco.cus.cam.ac.uk>
Message-ID: <Pine.SOL.3.96.1020817010351.25629C-100000@draco.cus.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Apologies for the repost but I got Alan's address wrong first time
round... silly cut'n'paste error...]

On Fri, 16 Aug 2002, Linus Torvalds wrote:
> I'm dreaming of an IDE maintainer that people (including, very much, me)
> can work with. I don't know why, but IDE has pretty much since day one
> been a fairly problematic area, and has caused a lot more maintainer
> headache than the rest of the kernel put together..
> 
> There's been one fairly smooth IDE transition (the original transition
> from hd.c to ide.c), and calling even that "smooth" is pretty much all
> hindsight - at the time people thought it was horribly stupid to not allow
> big controversial changes to hd.c, and the resulting code duplication was
> considered a disaster.
> 
> Right now it looks like Alan is at least for the moment willing to work on
> the IDE code, which is obviously great. I just wonder how long he'll stand
> it (he's maintained various IDE buglists etc issues for years, so we can
> hope).

Linus,

Out of curiosity, who is going to be IDE 2.5 kernel maintainer now?

I am assuming you still maintain that working with Andre is difficult for
you...

Further, I am assuming that Alan is not going to be wanting to be IDE 2.5
maintainer. (I may be completely wrong of course... Alan?)

Jens perhaps? Again I assume he doesn't want the job. (Again, I may be
completely wrong... Jens?)

How about Bartlomiej Zolnierkiewicz as IDE 2.5 maintainer? He seems to be
happy to talk to Andre. And you are perhaps able to work with him well?
He has been submitting bug fixes to Martin and seems to generally know
what he is doing with IDE, certainly a lot better than many of us...

If you can work with him, then it would seem he would be well suited for
the job... Assuming he wants it... Bartlomiej?

Just my curious 2p...

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/


