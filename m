Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269735AbRHIIdt>; Thu, 9 Aug 2001 04:33:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269737AbRHIIdi>; Thu, 9 Aug 2001 04:33:38 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:62473 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S269735AbRHIIdW>;
	Thu, 9 Aug 2001 04:33:22 -0400
Date: Thu, 9 Aug 2001 10:33:09 +0200
From: Jens Axboe <axboe@suse.de>
To: Paul Jakma <paulj@alphyra.ie>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Peter Osterlund <peter.osterlund@mailbox.swipnet.se>,
        linux-kernel@vger.kernel.org
Subject: Re: kupdated oops in 2.4.8-pre5
Message-ID: <20010809103309.V4587@suse.de>
In-Reply-To: <Pine.LNX.4.33.0108071433480.1434-100000@penguin.transmeta.com> <Pine.LNX.4.33.0108090923030.13822-100000@dunlop.itg.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0108090923030.13822-100000@dunlop.itg.ie>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 09 2001, Paul Jakma wrote:
> On Tue, 7 Aug 2001, Linus Torvalds wrote:
> 
> > Yes, stupid lost test. Already fixed in -pre6.
> 
> Hi Linus,
> 
> I'm seeing what appears to be the same problem in pre7, can trigger
> it reliably:

Double check your source, afaics it can't happen in pre7.

-- 
Jens Axboe

