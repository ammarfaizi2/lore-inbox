Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277286AbRJJPv6>; Wed, 10 Oct 2001 11:51:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277285AbRJJPvi>; Wed, 10 Oct 2001 11:51:38 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:2063 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S277284AbRJJPvh>; Wed, 10 Oct 2001 11:51:37 -0400
Date: Wed, 10 Oct 2001 12:51:51 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Erik Gustavsson <cyrano@algonet.se>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.10-acX VM troubles
In-Reply-To: <Pine.LNX.4.21.0110101727070.777-100000@lillan>
Message-ID: <Pine.LNX.4.33L.0110101249370.26495-100000@duckman.distro.conectiva>
X-supervisor: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Oct 2001, Erik Gustavsson wrote:

> At first I thought that the VM in 2.4.10-acX (I've tried ac3 and ac7) was
> a big improvement over vanilla 2.4.9 (my previous kernel). But after
> playing around with different versions and patches, and actually running
> the same kernel for a day or more I ran into severe problems.

I've already put out a patch which tries to fix this problem,
once we've established that it indeed works as advertised and
doesn't have bad side effects, I'll ask Alan to integrate it:

http://www.surriel.com/patches/2.4/2.4.10-ac9-eatcache

The patch applies cleanly to at least 2.4.10-ac9 and -ac10,
maybe a few others too.

It would be nice to know if this patch fixes the problems for
you, if it does there's another reason to ask Alan to integrate
it ... if it doesn't I'll try to make it work before sending
the thing to Alan.

regards,

Rik
-- 
DMCA, SSSCA, W3C?  Who cares?  http://thefreeworld.net/  (volunteers needed)

http://www.surriel.com/		http://distro.conectiva.com/

