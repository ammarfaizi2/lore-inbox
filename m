Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261761AbSJQRX1>; Thu, 17 Oct 2002 13:23:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261753AbSJQRVu>; Thu, 17 Oct 2002 13:21:50 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:60944 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261747AbSJQRSp>; Thu, 17 Oct 2002 13:18:45 -0400
Date: Thu, 17 Oct 2002 10:26:41 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: Christoph Hellwig <hch@infradead.org>, Crispin Cowan <crispin@wirex.com>,
       Greg KH <greg@kroah.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] make LSM register functions GPLonly exports
In-Reply-To: <Pine.LNX.3.95.1021017130633.6772A-200000@chaos.analogic.com>
Message-ID: <Pine.LNX.4.44.0210171025490.7066-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 17 Oct 2002, Richard B. Johnson wrote:
> 
> This, by example, shows that "GPL Only" is unenforceable.  I suggest
> that all the "GPL only" zealots try something new (like more good code),
> rather than attempting to prevent honest workers from using code
> they helped develop.

You misunderstand what GPLONLY is all about.

It's not a change to the license. It's a click-through (ie you have to 
actually do something specific to make "insmod" even load your license).

		Linus

