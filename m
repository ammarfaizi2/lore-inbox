Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269583AbRHIKLs>; Thu, 9 Aug 2001 06:11:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269646AbRHIKLh>; Thu, 9 Aug 2001 06:11:37 -0400
Received: from [193.120.224.170] ([193.120.224.170]:49549 "EHLO
	florence.itg.ie") by vger.kernel.org with ESMTP id <S269583AbRHIKL0>;
	Thu, 9 Aug 2001 06:11:26 -0400
Date: Thu, 9 Aug 2001 11:11:33 +0100 (IST)
From: Paul Jakma <paulj@alphyra.ie>
To: Jens Axboe <axboe@suse.de>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Peter Osterlund <peter.osterlund@mailbox.swipnet.se>,
        <linux-kernel@vger.kernel.org>
Subject: Re: kupdated oops in 2.4.8-pre5
In-Reply-To: <Pine.LNX.4.33.0108090956290.13822-100000@dunlop.itg.ie>
Message-ID: <Pine.LNX.4.33.0108091039210.13876-100000@dunlop.itg.ie>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Aug 2001, Paul Jakma wrote:

> lockup with pre7 (but without oops).

clarification: if there is an oops, it isn't making it to the disk.

as my test case is in X, i can't see whether there is an oops on
console. i've tried to trigger it by running gtv, switching to console
and killing gtv - but not had any luck.

--paulj


