Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286145AbRLTF5B>; Thu, 20 Dec 2001 00:57:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286146AbRLTF4v>; Thu, 20 Dec 2001 00:56:51 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:50704 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S286145AbRLTF4o>; Thu, 20 Dec 2001 00:56:44 -0500
Date: Wed, 19 Dec 2001 21:55:18 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: James Cleverdon <jamesclv@us.ibm.com>
cc: <linux-kernel@vger.kernel.org>, Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [PATCH] MAX_MP_BUSSES increase
In-Reply-To: <200112200428.fBK4SNq29583@butler1.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.33.0112192154190.19321-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 19 Dec 2001, James Cleverdon wrote:
>
> Marcello and Linus, please apply.

Can you give a rough description of what kinds of arrays this will impact,
just out of curiosity. Ie do we talk about "5kB more memory in order to
avoid problems", or are we talking about something noticeable..

		Linus "too lazy to grep" Torvalds

