Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286590AbSAUNzA>; Mon, 21 Jan 2002 08:55:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286647AbSAUNyu>; Mon, 21 Jan 2002 08:54:50 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:30219 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S286590AbSAUNyl>;
	Mon, 21 Jan 2002 08:54:41 -0500
Date: Mon, 21 Jan 2002 11:54:13 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Hans Reiser <reiser@namesys.com>
Cc: Shawn Starr <spstarr@sh0n.net>, <linux-kernel@vger.kernel.org>
Subject: Re: Possible Idea with filesystem buffering.
In-Reply-To: <3C4C1AAF.8040303@namesys.com>
Message-ID: <Pine.LNX.4.33L.0201211153110.32617-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Jan 2002, Hans Reiser wrote:

> Pressure received is not equal to pages yielded. ... The number of
> pages yielded should depend on the interplay of pressure received and
> accesses made.
>
> Does this make more sense now?

Nice recipie for total chaos.  You _know_ each filesystem will
behave differently in this respect, it'll be impossible to get
the VM balanced in this way...

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

