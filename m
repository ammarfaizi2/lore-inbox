Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136327AbRDWBM6>; Sun, 22 Apr 2001 21:12:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136326AbRDWBMt>; Sun, 22 Apr 2001 21:12:49 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:19490 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S136330AbRDWBMf>; Sun, 22 Apr 2001 21:12:35 -0400
Date: Mon, 23 Apr 2001 03:12:27 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "D . W . Howells" <dhowells@astarte.free-online.co.uk>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org, dhowells@redhat.com
Subject: Re: [PATCH] rw_semaphores, optimisations
Message-ID: <20010423031227.E21558@athlon.random>
In-Reply-To: <01042223522900.05293@orion.ddi.co.uk> <20010423030441.D21558@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010423030441.D21558@athlon.random>; from andrea@suse.de on Mon, Apr 23, 2001 at 03:04:41AM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 23, 2001 at 03:04:41AM +0200, Andrea Arcangeli wrote:
> that is supposed to be a performance optimization, I do the same too in my code.

ah no I see what you mean, yes you are hurted by that. I'm waiting your #try 3
against pre6, by that time I hope to be able to make a run of the benchmark of
my asm version too (I will grow the graph).

Andrea
