Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750810AbVKZKfL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750810AbVKZKfL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Nov 2005 05:35:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750817AbVKZKfL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Nov 2005 05:35:11 -0500
Received: from smtp-106-saturday.noc.nerim.net ([62.4.17.106]:42507 "EHLO
	mallaury.nerim.net") by vger.kernel.org with ESMTP id S1750810AbVKZKfJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Nov 2005 05:35:09 -0500
Date: Sat, 26 Nov 2005 11:36:33 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Vishal Soni <vishal.linux@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: How to get SDA/SCL bit position in the control word register of
 the video card?
Message-Id: <20051126113633.4f2fb35a.khali@linux-fr.org>
In-Reply-To: <e3e24c6a0511252012v52a26698ua1d8b73eda2133fb@mail.gmail.com>
References: <e3e24c6a0511240245i1d395ae6g4d768a75a602d6ce@mail.gmail.com>
	<20051125203300.0899e9b7.khali@linux-fr.org>
	<e3e24c6a0511252012v52a26698ua1d8b73eda2133fb@mail.gmail.com>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vishal,

> On 11/26/05, Jean Delvare wrote:
> > First of all, I would suggest that you post using your real name.
> > Pretending that you are Linux on your own will not make you popular
> 
> This was funny and what is also sometimes considered as ASSUMING something
> and JUMPING to conclusion and JUDGING people without knowing them.

Calm down please.

I did not assume anything. You posted as "Vishal Linux", this is a
hard fact. I also did not judge you in any way. I merely *suggested* a
change, in your own interest.

The way people on this list perceive you will decide whether they are
going help you or not. Naming yourself "Vishal Linux" suggests that you
are the only person on Earth with first name "Vishal" who is entitled
to be related with the Linux kernel in any way. We expect more humility
from newcomers.

Additionnally, it's much easier to deal with the real names. There are
litterally thousands people posting to the LKML every year, having to
deal with nicknames or first names only makes it very hard to remember
who is who.

> I created email address vishal.linux so that i can dedicate one email
> address to the mailing lists for my linux interest and the hundred of
> mails, which keeps coming to the mailing list does not block my
> personal mails.

This is a technical detail. You can still post as "Vishal Soni" using
this second email address. I invite you do to so.

Now, feel free to ignore my suggestion. Just like I'll feel free to
ignore any further post from "Vishal Linux", especially if said post
includes slang, random insults, and abuses ellipsis.

> > > I tried to use linux kernel API char* get_EDID_from_BIOS(void*) and
> > > then using kgdb to debug the kernel module (that i wrote) to get the
> > > same  but failed to find the way to get the above.
> >
> > I couldn't find any function by that name in the Linux kernel source
> > tree. What are you talking about?
>
> /usr/src/linux-2.6.x/include/video/edid.h

There is no function by that name in that file, neither in Linus'
latest kernel, nor in Andrew Morton's one. Whatever you are talking
about does not seem to exist.

> Thankyou for your time.

You're welcome.

-- 
Jean Delvare
