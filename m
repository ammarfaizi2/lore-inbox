Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137110AbRA1OLr>; Sun, 28 Jan 2001 09:11:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137109AbRA1OLh>; Sun, 28 Jan 2001 09:11:37 -0500
Received: from anime.net ([63.172.78.150]:54032 "EHLO anime.net")
	by vger.kernel.org with ESMTP id <S137160AbRA1OLX>;
	Sun, 28 Jan 2001 09:11:23 -0500
Date: Sun, 28 Jan 2001 06:11:26 -0800 (PST)
From: Dan Hollis <goemon@anime.net>
To: Felix von Leitner <leitner@fefe.de>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: sendfile+zerocopy: fairly sexy (nothing to do with ECN)
In-Reply-To: <20010128143748.A9767@convergence.de>
Message-ID: <Pine.LNX.4.30.0101280609510.27435-100000@anime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 Jan 2001, Felix von Leitner wrote:
> What is missing here is a good authoritative web ressource that tells
> people which NIC to buy.
> I have a tulip NIC because a few years ago that apparently was the NIC
> of choice.  It has good multicast (which is important to me), but AFAIK
> it has neither scatter-gather nor hardware checksumming.
> Is there such a web page already?

http://www.anime.net/~goemon/cardz/

Based on discussions I've had with Donald Becker about chipsets.

For 100bt, 3c905C is the most efficient card at the moment.
I've no idea about gigglebit ethernet.

-Dan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
