Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131308AbRBESl6>; Mon, 5 Feb 2001 13:41:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131801AbRBESls>; Mon, 5 Feb 2001 13:41:48 -0500
Received: from [206.245.154.69] ([206.245.154.69]:61447 "HELO
	athena.intergrafix.net") by vger.kernel.org with SMTP
	id <S131308AbRBESll>; Mon, 5 Feb 2001 13:41:41 -0500
Date: Mon, 5 Feb 2001 13:41:39 -0500 (EST)
From: Admin Mailing Lists <mlist@intergrafix.net>
To: Peter Samuelson <peter@cadcamlab.org>
Cc: Bruce Harada <bruce@ask.ne.jp>, linux-kernel@vger.kernel.org
Subject: Re: rlim_t and DNS?
In-Reply-To: <20010201154005.B4161@cadcamlab.org>
Message-ID: <Pine.LNX.4.10.10102051339460.18021-100000@athena.intergrafix.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Yep, it is libc5. i have 1 glibc system and they both have the files
you've mentioned. :( either i'll have to upgrade to glibc (no small task)
or use 8.2.3 for now..the previous 8.2.2 series was compiling ok for me.
Unless someone has a workaround i might try for 9?

-Tony
.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-.
Anthony J. Biacco                       Network Administrator/Engineer
thelittleprince@asteroid-b612.org       Intergrafix Internet Services

    "Dream as if you'll live forever, live as if you'll die today"
http://www.asteroid-b612.org                http://www.intergrafix.net
.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-.

On Thu, 1 Feb 2001, Peter Samuelson wrote:

> 
> [Admin Mailing Lists]
> > i have no bits directory
> 
> Really?  What version of libc, and on what Linux distro?  I thought all
> versions of glibc2 had /usr/include/bits/.
> 
> If you are using libc4 or libc5, it is not surprising if the BIND
> people didn't notice the problem -- they probably didn't try it.
> 
> Peter
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
