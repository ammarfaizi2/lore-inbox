Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287578AbSBSXrp>; Tue, 19 Feb 2002 18:47:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289794AbSBSXrf>; Tue, 19 Feb 2002 18:47:35 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:12551 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S287578AbSBSXrb>;
	Tue, 19 Feb 2002 18:47:31 -0500
Date: Tue, 19 Feb 2002 20:47:17 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Larry McVoy <lm@bitmover.com>
Subject: [PATCH] struct page, new bk tree
Message-ID: <Pine.LNX.4.33L.0202192044140.7820-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

I've removed the old (broken) bitkeeper tree with the
struct page changes and have put a new one in the same
place ... with the struct page changes in one changeset
with ready checkin comment.

You can resync from bk://linuxvm.bkbits.net/linux-2.5-struct_page
and you'll see that the stupid etc/config change is no longer there.

If you want to wait a version with pulling this change because
of the pte_highmem changes by Ingo and Arjan I can understand
that and will just bug you again in a version or so ;)

kind regards,

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

