Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263165AbRFGVGu>; Thu, 7 Jun 2001 17:06:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263160AbRFGVGa>; Thu, 7 Jun 2001 17:06:30 -0400
Received: from h24-65-193-28.cg.shawcable.net ([24.65.193.28]:25072 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S263159AbRFGVGW>; Thu, 7 Jun 2001 17:06:22 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200106072105.f57L5HXp005687@webber.adilger.int>
Subject: Re: Background scanning change on 2.4.6-pre1
In-Reply-To: <Pine.LNX.4.21.0106071330060.6510-100000@penguin.transmeta.com>
 "from Linus Torvalds at Jun 7, 2001 01:43:33 pm"
To: Linus Torvalds <torvalds@transmeta.com>
Date: Thu, 7 Jun 2001 15:05:16 -0600 (MDT)
CC: Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus writes:
> On Thu, 7 Jun 2001, Marcelo Tosatti wrote:
> > Who did this change to refill_inactive_scan() in 2.4.6-pre1 ? 
> 
> I think it was Andreas Dilger..

Definitely NOT.  I don't touch MM stuff.  I do filesystems and LVM only.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
