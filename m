Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316080AbSFFKIc>; Thu, 6 Jun 2002 06:08:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316404AbSFFKIb>; Thu, 6 Jun 2002 06:08:31 -0400
Received: from nick.dcs.qmul.ac.uk ([138.37.88.61]:4523 "EHLO
	nick.dcs.qmul.ac.uk") by vger.kernel.org with ESMTP
	id <S316080AbSFFKIa>; Thu, 6 Jun 2002 06:08:30 -0400
Date: Thu, 6 Jun 2002 11:11:09 +0100 (BST)
From: Matt Bernstein <matt@theBachChoir.org.uk>
X-X-Sender: mb@jester.mews
To: dean gaudet <dean-list-linux-kernel@arctic.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19-pre10-ac2
In-Reply-To: <Pine.LNX.4.44.0206051204070.11987-100000@twinlark.arctic.org>
Message-ID: <Pine.LNX.4.44.0206061110410.16548-100000@jester.mews>
X-URL: http://www.theBachChoir.org.uk/
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-uvscan-result: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since when was it OK to do a parallel make dep?

On Jun 5 dean gaudet wrote:

>so i haven't had a chance to dig into this further, but i think there may
>be some .PRECIOUS foo missing.  i had hit ^C a few times to cancel out a
>"make -j3 dep", and a "make -j3 bzImage" while i tweaked other things...
>and somehow in the process include/linux/sunrpc/svcsock.h disappeared.

