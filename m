Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316857AbSE1Rik>; Tue, 28 May 2002 13:38:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316861AbSE1Rij>; Tue, 28 May 2002 13:38:39 -0400
Received: from nick.dcs.qmul.ac.uk ([138.37.88.61]:50136 "EHLO
	nick.dcs.qmul.ac.uk") by vger.kernel.org with ESMTP
	id <S316857AbSE1Rii>; Tue, 28 May 2002 13:38:38 -0400
Date: Tue, 28 May 2002 18:38:37 +0100 (BST)
From: Matt Bernstein <matt@theBachChoir.org.uk>
To: linux-kernel@vger.kernel.org
Subject: Re: VM oops in RH7.3 2.4.18-3
In-Reply-To: <Pine.LNX.4.44.0205271518270.5065-100000@nick.dcs.qmul.ac.uk>
Message-ID: <Pine.LNX.4.44.0205281834580.5065-100000@nick.dcs.qmul.ac.uk>
X-URL: http://www.theBachChoir.org.uk/
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-uvscan-result: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

memtest86 3.0 (which knows something about ECC :) found the problem in
seconds. It had passed a memtest86 2.something months ago before going
into production. Case closed--thanks/sorry!

On May 27 Matt Bernstein wrote:

>This is a dual Athlon, 1 gig registered ECC DDR RAM, will try 2.4.18-4 but
>it doesn't look ext3-related (the only big local filesystem is reiserfs
>over s/w raid0).

