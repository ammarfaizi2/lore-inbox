Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262022AbREYXT6>; Fri, 25 May 2001 19:19:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262027AbREYXTs>; Fri, 25 May 2001 19:19:48 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:53771 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S262022AbREYXTn>; Fri, 25 May 2001 19:19:43 -0400
Date: Fri, 25 May 2001 20:19:39 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [with-PATCH-really] highmem deadlock removal, balancing & cleanup
In-Reply-To: <E153Qld-0007Df-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0105252018310.10469-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 May 2001, Alan Cox wrote:

> But Linus is right I think - VM changes often prove
> 'interesting'. Test it in -ac , gets some figures for real world
> use then plan further

Oh well. As long as he takes the patch to page_alloc.c, otherwise
everybody _will_ have to "experiment" with the -ac kernels just
to have a system with highmem which doesn't deadlock ;)

cheers,

Rik
--
Linux MM bugzilla: http://linux-mm.org/bugzilla.shtml

Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

