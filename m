Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273656AbRI0QIg>; Thu, 27 Sep 2001 12:08:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273658AbRI0QI1>; Thu, 27 Sep 2001 12:08:27 -0400
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:5892 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S273656AbRI0QIX>; Thu, 27 Sep 2001 12:08:23 -0400
Date: Thu, 27 Sep 2001 18:08:49 +0200 (CEST)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Reply-To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Linux 0.01 disk lockup
In-Reply-To: <Pine.LNX.4.33.0109270826060.17030-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.3.96.1010927175126.12043B-100000@artax.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Linux 0.01 has a bug in disk request sorting - when interrupt happens
> > while sorting is active, the interrupt routine won't clear do_hd - thus
> > the disk will stay locked up forever.
> 
> Ehh..
> 
> Mikulas, do you want to be the official maintainer for the 0.01.xxx
> series?
> 
> Note that much of the maintenance work is probably just to reproduce and
> make all the user-level etc infrastructure available..

It would be cool to have linux-0.01 distribution. I started to use linux
in 2.0 times, so I'm probably not the right person to maintain it. I don't
even know where to get programs for it and I doubt it would work on my 4G
disk.

Mikulas




