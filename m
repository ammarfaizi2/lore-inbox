Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278781AbRJZRjA>; Fri, 26 Oct 2001 13:39:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278771AbRJZRil>; Fri, 26 Oct 2001 13:38:41 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:35599 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S278781AbRJZRiX>; Fri, 26 Oct 2001 13:38:23 -0400
Date: Fri, 26 Oct 2001 15:38:37 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Jeff Golds <jgolds@resilience.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Deadlock with linux kernel
In-Reply-To: <3BD9AC67.C959E3CB@resilience.com>
Message-ID: <Pine.LNX.4.33L.0110261537170.22127-100000@duckman.distro.conectiva>
X-supervisor: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Oct 2001, Jeff Golds wrote:

> I've been having this problem since 2.4.6 and just attributed it to VM
> issues.  However, I've been trying all the latest kernels (2.4.9-acXX,
> 2.4.10-acXX, 2.4.12-acXX and 2.4.13) and am still getting a deadlock
> scenario someplace.  In fact, my system hung up in about 2 minutes after
> booting the 2.4.13 kernel.

Since your system hangs just after boot, while you still
have free ram and tons of swap, in kernels with 3 different
VM subsystems ... I'm pretty sure this isn't a VM problem.

regards,

Rik
-- 
DMCA, SSSCA, W3C?  Who cares?  http://thefreeworld.net/  (volunteers needed)

http://www.surriel.com/		http://distro.conectiva.com/

