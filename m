Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135842AbRDZSLy>; Thu, 26 Apr 2001 14:11:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135822AbRDZSLf>; Thu, 26 Apr 2001 14:11:35 -0400
Received: from cr626425-a.bloor1.on.wave.home.com ([24.156.35.8]:30725 "EHLO
	spqr.damncats.org") by vger.kernel.org with ESMTP
	id <S135817AbRDZSLY>; Thu, 26 Apr 2001 14:11:24 -0400
Date: Thu, 26 Apr 2001 14:11:25 -0400 (EDT)
From: John Cavan <johnc@damncats.org>
To: imel96@trustix.co.id
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Single user linux
In-Reply-To: <Pine.LNX.4.33.0104261836130.1677-100000@tessy.trustix.co.id>
Message-ID: <Pine.LNX.4.10.10104261406420.20975-100000@spqr.damncats.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 26 Apr 2001 imel96@trustix.co.id wrote:
> you're right, we could do it in more than one way. like copying
> with mcopy without mounting a fat disk. the question is where to put it.
> why we do it is an important thing.
> taking place as a clueless user, i think i should be able to do anything.
> i'd be happy to accept proof that multi-user is a solution for
> clueless user, not because it's proven on servers. but because it is
> a solution by definition.
> 

I think you have it backwards here, given that Linux works one way and you
want it to work another. Basically, I would suggest that it is up to you
to prove that multi-user is NOT a solution for "clueless" user, especially
given that there have been a number of suggestions on how to do it without
changing the kernel or even changing software.

If you can't prove the case, I rather suspect that your patch won't make
it. Don't feel bad though, I've yet to get one through either. :o)

John

