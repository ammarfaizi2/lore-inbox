Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286178AbRLTGMm>; Thu, 20 Dec 2001 01:12:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286176AbRLTGM1>; Thu, 20 Dec 2001 01:12:27 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:19729 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S286158AbRLTGKr>; Thu, 20 Dec 2001 01:10:47 -0500
Date: Wed, 19 Dec 2001 22:09:40 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: "David S. Miller" <davem@redhat.com>
cc: <bcrl@redhat.com>, <cs@zip.com.au>, <billh@tierra.ucsd.edu>,
        <linux-kernel@vger.kernel.org>, <linux-aio@kvack.org>
Subject: Re: aio
In-Reply-To: <20011219.220247.101870714.davem@redhat.com>
Message-ID: <Pine.LNX.4.33.0112192206400.19394-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Could we get back on track, and possibly discuss the patches themselves,
ok? We want _constructive_ criticism of the interfaces.

I think it's clear that many people do want to have aio support. At least
as far as I'm concerned, that's not the reason I want to have public
discussion. I want to make sure that the interfaces are good for aio
users, and that the design isn't stupid.

If somebody can point to a better way of doing aio, and giving good
arguments for that, more power to him. But let's not go down the path of
"_I_ don't like aio, so _you_ must be stupid".

		Linus

