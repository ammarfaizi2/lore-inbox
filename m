Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288594AbSATN4o>; Sun, 20 Jan 2002 08:56:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288597AbSATN4e>; Sun, 20 Jan 2002 08:56:34 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:42257 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S288594AbSATN4b>;
	Sun, 20 Jan 2002 08:56:31 -0500
Date: Sun, 20 Jan 2002 11:56:24 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Hans Reiser <reiser@namesys.com>
Cc: Shawn <spstarr@sh0n.net>, <linux-kernel@vger.kernel.org>
Subject: Re: Possible Idea with filesystem buffering.
In-Reply-To: <3C4AAA95.8040702@namesys.com>
Message-ID: <Pine.LNX.4.33L.0201201155380.32617-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Jan 2002, Hans Reiser wrote:

> In version 4 of reiserfs, our plan is to implement writepage such that
> it does not write the page but instead pressures the reiser4 cache and
> marks the page as recently accessed.

What is this supposed to achieve ?

> Personally, I think that makes writepage the wrong name for that
> function, but I must admit it gets the job done,

And what job would that be ?

regards,

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

