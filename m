Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283080AbRLIGU7>; Sun, 9 Dec 2001 01:20:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283087AbRLIGUu>; Sun, 9 Dec 2001 01:20:50 -0500
Received: from [202.135.142.196] ([202.135.142.196]:40965 "EHLO wagner")
	by vger.kernel.org with ESMTP id <S283080AbRLIGUb>;
	Sun, 9 Dec 2001 01:20:31 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, anton@samba.org, davej@suse.de,
        marcelo@conectiva.com.br, lkml <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: Linux 2.4.17-pre5 
In-Reply-To: Your message of "Sat, 08 Dec 2001 18:35:28 -0800."
             <Pine.LNX.4.40.0112081824210.1019-100000@blue1.dev.mcafeelabs.com> 
Date: Sun, 09 Dec 2001 17:20:18 +1100
Message-Id: <E16CxJy-0000DO-00@wagner>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.40.0112081824210.1019-100000@blue1.dev.mcafeelabs.com> you write:
> It's not easy to get this right anyway.

Balancing the pull and push mechanisms in the scheduler while trying
to predict the future?  "Not easy" is an excellent description.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
