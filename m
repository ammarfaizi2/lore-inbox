Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291802AbSBHUoU>; Fri, 8 Feb 2002 15:44:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291806AbSBHUoC>; Fri, 8 Feb 2002 15:44:02 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:5134 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S291802AbSBHUnt>; Fri, 8 Feb 2002 15:43:49 -0500
Date: Fri, 8 Feb 2002 18:43:23 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Andrew Morton <akpm@zip.com.au>
Cc: Dieter =?iso-8859-1?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>,
        Jens Axboe <axboe@suse.de>, Ingo Molnar <mingo@elte.hu>,
        Robert Love <rml@tech9.net>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] get_request starvation fix
In-Reply-To: <3C642A90.751BB750@zip.com.au>
Message-ID: <Pine.LNX.4.33L.0202081842560.12225-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Feb 2002, Andrew Morton wrote:

> In other words: if you run dbench, then lilo, lilo will not complete
> until after dbench terminates.

Actually, lilo completed after 5 minutes, but still only
about halfway through the dbench.

Rik
-- 
Will hack the VM for food.

http://www.surriel.com/		http://distro.conectiva.com/

