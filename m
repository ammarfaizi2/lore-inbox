Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271105AbRHOJL3>; Wed, 15 Aug 2001 05:11:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271107AbRHOJLT>; Wed, 15 Aug 2001 05:11:19 -0400
Received: from shad0w.dial.nildram.co.uk ([195.112.18.51]:5642 "EHLO
	mail.shad0w.org.uk") by vger.kernel.org with ESMTP
	id <S271105AbRHOJLL>; Wed, 15 Aug 2001 05:11:11 -0400
Date: Wed, 15 Aug 2001 10:13:15 +0100 (BST)
From: Chris Crowther <chrisc@shad0w.org.uk>
To: "David S. Miller" <davem@redhat.com>
cc: <goemon@anime.net>, <alan@lxorguk.ukuu.org.uk>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] CDP handler for linux
In-Reply-To: <20010814.154609.99205977.davem@redhat.com>
Message-ID: <Pine.LNX.4.33.0108151011100.2889-100000@monolith.shad0w.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Aug 2001, David S. Miller wrote:

>    Except that as userspace daemon if cdpd goes splat the kernel generally
>    doesnt go splat either.

	Funny you should mention that, but it do that a few times while I
was writing it :)  Anyway, I'm going to daemonise it, just as soon as I
figure out how.

	It it possible to register a function in a userspace app as a SNAP
handler?

-- 
Chris "_Shad0w_" Crowther
chrisc@shad0w.org.uk
http://www.shad0w.org.uk/

