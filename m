Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267325AbSKPSIT>; Sat, 16 Nov 2002 13:08:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267327AbSKPSIT>; Sat, 16 Nov 2002 13:08:19 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:64517 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267325AbSKPSIS>; Sat, 16 Nov 2002 13:08:18 -0500
Date: Sat, 16 Nov 2002 10:15:04 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rik van Riel <riel@conectiva.com.br>
cc: Jeff Garzik <jgarzik@pobox.com>, <David.Mosberger@acm.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] remove hugetlb syscalls
In-Reply-To: <Pine.LNX.4.44L.0211161559270.4103-100000@imladris.surriel.com>
Message-ID: <Pine.LNX.4.44.0211161008140.15838-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 16 Nov 2002, Rik van Riel wrote:
> 
> This always happens when the discussions occurred in private and
> 99% of the community didn't see them.  No need to be surprised
> that people are asking the questions others have answered before
> in a place nobody could see ;)

Part of the problem is that the companies involved (mainly Intel and
Oracle) both have a hard time just talking about their stuff in public on
linux-kernel.  It looks like Intel is getting a lot better at it, it's
been my one major message to the people there I know. Oracle engineers
still don't seem to talk much publicly about their issues and trials,
though.

(Part of that may actually be due to stupid benchmark rules. They aren't 
even allowed to publicize their basic benchmark numbers while doing 
development, even though those numbers are the primary thing they care 
about. Frigging stupid rules, entirely designed for closed development.)

So not only did you have a feature that is mostly useful only to a 
smallish group of people - you had that group of people not used to open 
communication in the first place, AND you had rules that made some of the 
important part of the communication illegal in the first place.

Still wonder why it wasn't widely discussed during development? Intel 
engineers would bvasically take people asdie in private at conferences 
talking about what kinds of improvments Oracle was seeing..

Oh, well. 

		Linus

