Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281343AbRKEVIw>; Mon, 5 Nov 2001 16:08:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281339AbRKEVIn>; Mon, 5 Nov 2001 16:08:43 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:14096 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S281343AbRKEVIe>; Mon, 5 Nov 2001 16:08:34 -0500
Date: Mon, 5 Nov 2001 19:08:26 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Thomas Koeller <tkoeller@gmx.net>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Scheduling of low-priority background processes
In-Reply-To: <01110521533900.00641@sarkovy.koeller.org>
Message-ID: <Pine.LNX.4.33L.0111051906560.27028-100000@duckman.distro.conectiva>
X-supervisor: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Nov 2001, Thomas Koeller wrote:

> So here is my question:
>
> Some operating systems I have been working with had a scheduling
> policy different from what I find in Linux.

I'm not sure what you want to ask, though I guess you're not
too happy about the fact that niced processes still get a lot
of CPU time in Linux ;)

If this was what you wanted to say, this is something I've been
planning to fix for a while and, now that my VM has been removed
from the kernel, I'll have some time for too...

cheers,

Rik
-- 
DMCA, SSSCA, W3C?  Who cares?  http://thefreeworld.net/  (volunteers needed)

http://www.surriel.com/		http://distro.conectiva.com/

