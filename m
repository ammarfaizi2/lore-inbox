Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313309AbSDOVry>; Mon, 15 Apr 2002 17:47:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313311AbSDOVrx>; Mon, 15 Apr 2002 17:47:53 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:18449 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S313309AbSDOVrw>;
	Mon, 15 Apr 2002 17:47:52 -0400
Date: Mon, 15 Apr 2002 18:47:31 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, <wli@holomorphy.com>
Subject: Re: [PATCH] for_each_zone / for_each_pgdat
In-Reply-To: <Pine.LNX.4.33.0204151400200.13034-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.44L.0204151838020.1960-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Apr 2002, Linus Torvalds wrote:

> Which requires the user to use something like
>
> 	for_each_zone(zone) {
> 		...
> 	} end_zone;

You just pinpointed the reason we didn't do what you wrote down ;)

We can change the code to your liking, though.

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

