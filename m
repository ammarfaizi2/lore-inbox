Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129598AbRCTDgH>; Mon, 19 Mar 2001 22:36:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129624AbRCTDf5>; Mon, 19 Mar 2001 22:35:57 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:22022 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129598AbRCTDfv>; Mon, 19 Mar 2001 22:35:51 -0500
Date: Mon, 19 Mar 2001 19:35:08 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrew Morton <andrewm@uow.edu.au>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin" <hpa@transmeta.com>
Subject: Re: 3rd version of R/W mmap_sem patch available
In-Reply-To: <3AB6C7C2.D1A49FEF@uow.edu.au>
Message-ID: <Pine.LNX.4.31.0103191932240.7210-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 20 Mar 2001, Andrew Morton wrote:
> Linus Torvalds wrote:
> >
> > There is a 2.4.3-pre5 in the test-directory on ftp.kernel.org.
>
> I can't see it.  Where did you hide it?

Ahh. The mirroring is apparently broken. I put my stuff on a faster local
connection to "master.kernel.org", and depend on it being mirrored
automatically. And apparently the mirroring has been down for a few days
now. Ugh. I'll ping Peter.

		Linus

