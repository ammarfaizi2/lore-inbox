Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129661AbRBLPfV>; Mon, 12 Feb 2001 10:35:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129811AbRBLPfM>; Mon, 12 Feb 2001 10:35:12 -0500
Received: from relais.videotron.ca ([24.201.245.36]:35761 "EHLO
	VL-MS-MR003.sc1.videotron.ca") by vger.kernel.org with ESMTP
	id <S129661AbRBLPfB>; Mon, 12 Feb 2001 10:35:01 -0500
Message-ID: <3A880004.51C92911@videotron.ca>
Date: Mon, 12 Feb 2001 10:23:48 -0500
From: Martin Laberge <mlsoft@videotron.ca>
Organization: MLSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.18 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Juergen Schneider <juergen.schneider@tuxia.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Animated framebuffer logo for 2.4.1
In-Reply-To: <20010201183231.A373@tuxia.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Juergen Schneider wrote:

> Hello everybody,
>
> I've created a patch for kernel 2.4.1 that adds some fancy options for
> the framebuffer console driver concerning the boot logo.
> I've added logo animation and logo centering.
> People may find this not very useful but nice to look at. :-)
>
> It can be downloaded from:
>    <ftp://ftp.tuxia.com/pub/linux/tuxia/anim-logo/AnimLogo.tgz>
>
> With this tar ball comes the patch for kernel 2.4.1 and a small
> program called xpm2splash to create animated linux_logo.h files
> from XPM files.
> The patch also contains an animated boot logo (that's why it is
> so big).
> It is the dancing penguin I've taken from the apache default
> configuration of a SuSE 6.4 distribution.
> (BTW who created this nice animation???)
>
> So, try it and send your comments.
>
> Juergen Schneider
>
> PS: The patch should work with kernel 2.4.0 too.
>
> PPS: Our FTP server seems to have some problems with the "ls"
>      command. You should use "ls -l" or "dir" to get a
>      directory listing. Sorry for that.
>
> --
> Dipl.-Inf. Juergen Schneider                    <juergen.schneider@tuxia.com>
> TUXIA Deutschland GmbH
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

I beleive it is a very good idea... there has been many objections where
SYSTEM-HANG or CRASH or ANY-BAD-THING
would be difficult to trace for the geek... BUT , are you all believing the
system will be crashing most of the time, or will it be
running perfectly most of the time...

I want to install a system where my expectations, (when fully installed and
configured, once at the start) is for the system
to boot perfectly and do it's job MOST of the time, and if possible ALL of the
time.

I believe linux should be one of those systems... you start it and then use
it... it don't crash, don't hang...   it works...

Then it is a good idea to have a nice boot logo when the system start... for
your user happyness...
we should never lose the idea that this system is intended to be USED by
someone, not just DEBUGGED.

Go on, i would like to see this kind of thing, and would use it...

Martin Laberge
mlsoft@videotron.ca



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
