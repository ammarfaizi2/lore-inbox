Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289470AbSAKDmh>; Thu, 10 Jan 2002 22:42:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289853AbSAKDm1>; Thu, 10 Jan 2002 22:42:27 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:13321 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S289851AbSAKDmX>;
	Thu, 10 Jan 2002 22:42:23 -0500
Date: Fri, 11 Jan 2002 01:42:03 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Pavel Machek <pavel@suse.cz>
Cc: "M. Edward (Ed) Borasky" <znmeb@aracnet.com>,
        Daniel Tuijnman <daniel@ATComputing.nl>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Memory management problems in 2.4.16
In-Reply-To: <20020110224036.GA32522@atrey.karlin.mff.cuni.cz>
Message-ID: <Pine.LNX.4.33L.0201110141090.2985-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jan 2002, Pavel Machek wrote:

> 8MB should be enough. I was running 2.4.0-test7 on 8MB machine with no
> swap, because it had no disk to swap to.

I've been running a few hours of low memory testing with
my rmap VM and it's holding up fine. The system is still
responsive when the amount of pageable RAM is down to
about 400 kB ;))

cheers,

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

