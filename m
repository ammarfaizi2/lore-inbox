Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135853AbREIEYy>; Wed, 9 May 2001 00:24:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135855AbREIEYp>; Wed, 9 May 2001 00:24:45 -0400
Received: from mailout2-0.nyroc.rr.com ([24.92.226.121]:18174 "EHLO
	mailout2-0.nyroc.rr.com") by vger.kernel.org with ESMTP
	id <S135853AbREIEY1>; Wed, 9 May 2001 00:24:27 -0400
Message-Id: <200105090424.AAA05768@soyata.home>
X-Mailer: exmh version 2.1.0 09/18/1999
To: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: Wow! Is memory ever cheap! 
In-Reply-To: Message from Larry McVoy <lm@bitmover.com> 
   of "Mon, 07 May 2001 11:56:59 PDT." <20010507115659.T14127@work.bitmover.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 09 May 2001 00:24:25 -0400
From: "Marty Leisner" <leisner@rochester.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm confused by the "lets not use ECC and use bk" talk.

My understanding is suns big machines stopped using ecc and they
started to have "random" problems running big-iron applications
that took them a while to figure out (and a lot of bad press) and can
only be rectified in the big cycle (this was last year so its probably solved 
now).

I thought one of the primary reasons to have ecc is to catch
wierd things before they become catostrophic...and at least
know WHY weirdness is happening...


marty

