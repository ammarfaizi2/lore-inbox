Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289733AbSBJTL7>; Sun, 10 Feb 2002 14:11:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289737AbSBJTLv>; Sun, 10 Feb 2002 14:11:51 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:25618 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S289733AbSBJTLo>; Sun, 10 Feb 2002 14:11:44 -0500
Date: Sun, 10 Feb 2002 12:57:11 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andreas Dilger <adilger@turbolabs.com>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>, Patrick Mochel <mochel@osdl.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [bk patch] Make cardbus compile in -pre4
In-Reply-To: <20020210004748.G9826@lynx.turbolabs.com>
Message-ID: <Pine.LNX.4.33.0202101250150.7412-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 10 Feb 2002, Andreas Dilger wrote:
>
> What about BK CSET (or regular patch) submissions from non-core
> developers?  Would you accept CSETs via email if they are preceeded
> by a unified diff and explanation?

What's the difference here with "bk send"?

I have worked with a few BK patches in email, and I have to say that I
pretty much detest them. The less I have to work with them, the better,
although that may just because I don't yet have the same kind of
infrastructure for them as I have for regulat patches.

Making the infrastructure is not that hard, so if people start sending me
bk patches by email, I can improve it, and I'll probably not dislike bk
send as much as I do now.

(But _please_ do a "bk send" to a file, and edit the file before you send
it, instead of sending directly with that "Bitkeeper patch" subject line.
It looks like "bk send" was really designed for automatic merges, not for
humans)

		Linus

