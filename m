Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129999AbQKFS5B>; Mon, 6 Nov 2000 13:57:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129984AbQKFS4v>; Mon, 6 Nov 2000 13:56:51 -0500
Received: from humbolt.geo.uu.nl ([131.211.28.48]:50704 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S129850AbQKFS4l>; Mon, 6 Nov 2000 13:56:41 -0500
Date: Mon, 6 Nov 2000 19:56:23 +0100 (CET)
From: Rik van Riel <riel@conectiva.com.br>
To: Szabolcs Szakacsits <szaka@f-secure.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Looking for better VM
In-Reply-To: <Pine.LNX.4.21.0011060854110.1242-100000@fs129-190.f-secure.com>
Message-ID: <Pine.LNX.4.05.10011061954520.26327-100000@humbolt.nl.linux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Nov 2000, Szabolcs Szakacsits wrote:
> On Wed, 1 Nov 2000, Rik van Riel wrote:
> 
> > but simply because 
> > it appears there has been amazingly little research on this 
> > subject and it's completely unknown which approach will work 
> 
> There has been lot of research, this is the reason most Unices support
> both non-overcommit and overcommit memory handling default to
> non-overcommit [think of reliability and high availability].

It's a shame you didn't take the trouble to actually
go out and see that non-overcommit doesn't solve the
"out of memory" deadlock problem.

[if you want an explanation, look in the archives,
we've explained this a dozen times now]

regards,

Rik
--
The Internet is not a network of computers. It is a network
of people. That is its real strength.

http://www.conectiva.com/		http://www.surriel.com/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
