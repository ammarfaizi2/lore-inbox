Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286968AbSBSTmq>; Tue, 19 Feb 2002 14:42:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286959AbSBSTmg>; Tue, 19 Feb 2002 14:42:36 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:28937 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S286411AbSBSTmT>;
	Tue, 19 Feb 2002 14:42:19 -0500
Date: Tue, 19 Feb 2002 16:41:55 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [PATCH *] new struct page shrinkage
In-Reply-To: <Pine.LNX.4.33.0202191116470.27806-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.33L.0202191640230.7820-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Feb 2002, Linus Torvalds wrote:

> Btw, _please_ don't do things like changing the bitkeeper etc/config
> file. Right now your very first changesets is something that I
> definitely do not want in my tree.

Since bk doesn't seem to let me remove the thing from the
history (probably with some good reason), I guess you
might as well import the following patch:

http://surriel.com/patches/2.5/2.5.5-p2-struct_page5

As a side effect, this patch should reduce the whole
thing to one changeset, which isn't all bad since we
don't need to have the history of Linux cluttered up
with all the minor changes to this patch ;)

regards,

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

