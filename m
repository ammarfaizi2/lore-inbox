Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280776AbRKSXoB>; Mon, 19 Nov 2001 18:44:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280774AbRKSXnl>; Mon, 19 Nov 2001 18:43:41 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:37642 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S280773AbRKSXnh>; Mon, 19 Nov 2001 18:43:37 -0500
Date: Mon, 19 Nov 2001 15:38:45 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Simon Kirby <sim@netnation.com>
cc: Andrea Arcangeli <andrea@suse.de>, <linux-kernel@vger.kernel.org>
Subject: Re: VM-related Oops: 2.4.15pre1
In-Reply-To: <20011119152745.A27716@netnation.com>
Message-ID: <Pine.LNX.4.33.0111191537450.19585-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 19 Nov 2001, Simon Kirby wrote:
>
> Well, I found out what file has the bog-standard page.
>
> open("/home/stevendi//.htaccess", O_RDONLY|O_LARGEFILE) = 4

What filesystem is this?

		Linus

