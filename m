Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293758AbSCKOG7>; Mon, 11 Mar 2002 09:06:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293746AbSCKOGz>; Mon, 11 Mar 2002 09:06:55 -0500
Received: from Expansa.sns.it ([192.167.206.189]:275 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S310123AbSCKOGj>;
	Mon, 11 Mar 2002 09:06:39 -0500
Date: Mon, 11 Mar 2002 15:05:42 +0100 (CET)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: Hans Reiser <reiser@namesys.com>
cc: Itai Nahshon <itai@siftology.com>, Larry McVoy <lm@bitmover.com>,
        Tom Lord <lord@regexps.com>, <jaharkes@cs.cmu.edu>,
        <linux-kernel@vger.kernel.org>
Subject: Re: linux-2.5.4-pre1 - bitkeeper testing
In-Reply-To: <3C8BBFCF.5010504@namesys.com>
Message-ID: <Pine.LNX.4.44.0203111503070.14393-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Revision controll was a nightmare with aleph DB on dear old VMS.
Had to clean older versions of the db every month, because, of course,
I could not have on the fs more than 32K versions...
well, Aleph was a nightmare itself, actually...


On Sun, 10 Mar 2002, Hans Reiser wrote:

> Itai Nahshon wrote:
>
> >On Sunday 10 March 2002 10:36, Hans Reiser wrote:
> >
> >>I think that if version control becomes as simple as turning on a plugin
> >>for a directory or file, and then adding a little to the end of a
> >>filename to see and list the old versions, Mom can use it.
> >>
> >
> >IIRC that was a feature in systems from DEC even before
> >VMS (I'm talking about the late 70's).  eg. file.txt;2 was revision 2
> >of file.txt.
> >
>
> Was it easy?  Did people like it?  Any lessons/successes?
>
> Hans
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

