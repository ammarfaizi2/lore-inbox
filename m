Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280150AbRKEDP4>; Sun, 4 Nov 2001 22:15:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280154AbRKEDPq>; Sun, 4 Nov 2001 22:15:46 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:14607 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S280150AbRKEDPf>;
	Sun, 4 Nov 2001 22:15:35 -0500
Date: Mon, 5 Nov 2001 01:15:10 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: Ed Tomlinson <tomlins@cam.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] vm_swap_full
In-Reply-To: <20011104191014.C16017@mikef-linux.matchmail.com>
Message-ID: <Pine.LNX.4.33L.0111050114250.2963-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 4 Nov 2001, Mike Fedyk wrote:

> But now that nr_swap_pages is *free* swap, you'll have to add another
> test for (swap > RAM)...

I talked about this thing with Ed on #kernelnewbies and
it turns out all which really needs to be added is some
proper documentation.

The thing is correct, but it confused me too at first ;)

cheers,

Rik
-- 
DMCA, SSSCA, W3C?  Who cares?  http://thefreeworld.net/

http://www.surriel.com/		http://distro.conectiva.com/

