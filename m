Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276231AbRI1Sgs>; Fri, 28 Sep 2001 14:36:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276232AbRI1Sgi>; Fri, 28 Sep 2001 14:36:38 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:28936 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S276231AbRI1SgY>; Fri, 28 Sep 2001 14:36:24 -0400
Date: Fri, 28 Sep 2001 15:36:33 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: bill davidsen <davidsen@tmr.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.9-ac16 good perfomer?
In-Reply-To: <200109281826.f8SIQLP06585@deathstar.prodigy.com>
Message-ID: <Pine.LNX.4.33L.0109281535220.26495-100000@duckman.distro.conectiva>
X-supervisor: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Sep 2001, bill davidsen wrote:

>   I have been playing with 2.4.9-ac16 and I note that on a small machine
> (without the highmem issues) it really seems much slower initially.
> After startx I pop up netscape for a test, and it takes almost 50%
> longer than 2.4.8-pre3 I've been running since it was new. After that it
> seems okay but not wildly better, my aim was to be able to use netscape
> and cdrecord and {anything_else} at the same time.

Mmmm, interesting.  Could you send me a screen worth of
top output and maybe 10 or 20 lines or so of 'vmstat 1'
output, both taken while the machine is going through a
hard time ?

Lets try to resolve this issue while we're at it ;)

regards,

Rik
--
IA64: a worthy successor to the i860.

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

