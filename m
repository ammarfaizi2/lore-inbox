Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315722AbSEZFpM>; Sun, 26 May 2002 01:45:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315725AbSEZFpL>; Sun, 26 May 2002 01:45:11 -0400
Received: from dsl-213-023-040-043.arcor-ip.net ([213.23.40.43]:21461 "EHLO
	starship") by vger.kernel.org with ESMTP id <S315722AbSEZFpK>;
	Sun, 26 May 2002 01:45:10 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Linus Torvalds <torvalds@transmeta.com>,
        Robert Schwebel <robert@schwebel.de>
Subject: Re: patent on O_ATOMICLOOKUP [Re: [PATCH] loopable tmpfs (2.4.17)]
Date: Sun, 26 May 2002 07:44:28 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0205251651460.4120-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17BqpQ-0003r3-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 26 May 2002 02:07, Linus Torvalds wrote:
> And once you lack kernel services, from a programming standpoint it
> shouldn't really matter whether it's a kernel module or not.

You're way underestimating the importance of memory protection, both for 
debugging and for those that-can-never-happen-but-it-did system recovery
situations.

-- 
Daniel
