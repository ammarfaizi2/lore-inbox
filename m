Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129431AbRAKAaV>; Wed, 10 Jan 2001 19:30:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130765AbRAKAaL>; Wed, 10 Jan 2001 19:30:11 -0500
Received: from innerfire.net ([208.181.73.33]:29715 "HELO innerfire.net")
	by vger.kernel.org with SMTP id <S129873AbRAKA36>;
	Wed, 10 Jan 2001 19:29:58 -0500
Date: Wed, 10 Jan 2001 16:33:15 -0800 (PST)
From: Gerhard Mack <gmack@innerfire.net>
To: Eyal Lebedinsky <eyal@eyal.emu.id.au>
cc: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [Announcement] linux-kernel v2.0.39
In-Reply-To: <3A5CEFB7.18262D97@eyal.emu.id.au>
Message-ID: <Pine.LNX.4.10.10101101631320.4112-100000@innerfire.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

GCC 2.95 will NOT compile a 2.0 series kernel...

	Gerhard

> # gcc --version
> 2.95.2
> 
> # uname -a
> Linux eyal 2.4.0-ac3 #1 Sun Jan 7 12:15:50 EST 2001 i686 unknown
> 
> # ls -l /lib/libc-*.so
> -rwxr-xr-x    1 root     root      1057576 Oct 14 05:45
> /lib/libc-2.1.95.so
> 
> --
> Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.anu.edu.au/eyal/>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 

--
Gerhard Mack

gmack@innerfire.net

<>< As a computer I find your faith in technology amusing.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
