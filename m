Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288959AbSATXMH>; Sun, 20 Jan 2002 18:12:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288964AbSATXL4>; Sun, 20 Jan 2002 18:11:56 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:39173 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S288959AbSATXLn>;
	Sun, 20 Jan 2002 18:11:43 -0500
Date: Sun, 20 Jan 2002 21:11:13 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Shawn Starr <spstarr@sh0n.net>
Cc: Hans Reiser <reiser@namesys.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Possible Idea with filesystem buffering.
In-Reply-To: <Pine.LNX.4.40.0201201744480.459-100000@coredump.sh0n.net>
Message-ID: <Pine.LNX.4.33L.0201202110290.32617-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Jan 2002, Shawn Starr wrote:

> But why should each filesystem have to have a different method of
> buffering/caching? that just doesn't fit the layered model of the
> kernel IMHO.

I think Hans will give up the idea once he realises the
performance implications. ;)

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

