Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281808AbRKVWqD>; Thu, 22 Nov 2001 17:46:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281810AbRKVWpx>; Thu, 22 Nov 2001 17:45:53 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:11790 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S281808AbRKVWph>; Thu, 22 Nov 2001 17:45:37 -0500
Date: Thu, 22 Nov 2001 14:27:02 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Leif Sawyer <lsawyer@gci.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>, <leif@denali.net>
Subject: RE: Linux-2.4.15-pre9
In-Reply-To: <BF9651D8732ED311A61D00105A9CA31506DB3B73@berkeley.gci.com>
Message-ID: <Pine.LNX.4.33.0111221424010.1006-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 22 Nov 2001, Leif Sawyer wrote:
>
> This option works in 2.4.14 and prior.

Oh, I didn't notice this part.

If it actually works in 2.4.14, can you check _which_ pre-patch changes
behaviour? I don't see _any_ changes that look even remotely likely to
cause BIOS routines to oops, and it might just be random luck, for all I
know.

		Linus

