Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261842AbSJZDAs>; Fri, 25 Oct 2002 23:00:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261844AbSJZDAs>; Fri, 25 Oct 2002 23:00:48 -0400
Received: from portofix.ida.liu.se ([130.236.177.25]:28859 "EHLO
	portofix.ida.liu.se") by vger.kernel.org with ESMTP
	id <S261842AbSJZDAr>; Fri, 25 Oct 2002 23:00:47 -0400
Date: Sat, 26 Oct 2002 05:07:01 +0200 (MEST)
From: Adrian Pop <adrpo@ida.liu.se>
To: linux-kernel@vger.kernel.org
Subject: The pain with the Net Drivers (ne*, xirc2ps_c, etc)  
Message-ID: <Pine.GSO.4.44.0210260441200.11632-100000@mir20.ida.liu.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Sorry for bothering you people but i can't stand this anymore!
Trying to net-install a linux distribution or even get the
kenel to hack it and change these damn timeouts is impossible
since kernel 2.2 or so.
Should we throw these old network cards away and buy new ones?
Or we should probably install Windows to be able to download the
linux kernel and then to hack it?
I had to borrow another network card to upgrade my linux
after trying for 1 week to download it with xircom one.

Why can't you make the timeouts as parameters?

Now I need to restart my network card from 2 and 2 minutes to
be able to download more from the damn kernel.
It isn't a problem only for xirc2ps_cs, it is a problem for
ne drivers too and probably more others.
If you don't want your card to reset after
flooding your kernel log with tx timeouts you have to change the
timeouts by hand. Of course that is possible if you are EVER able to
download the hole kernel with the shitty driver you already have.

Well, that's about all.
Sorry for this email, i just reached the limit of my patience.

Now back to that "pushing the patience to the limits" game called
"downloading the kernel".

Regards,
Adi/

