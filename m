Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279749AbRKAUl1>; Thu, 1 Nov 2001 15:41:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279752AbRKAUlS>; Thu, 1 Nov 2001 15:41:18 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:49924 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S279749AbRKAUlH>; Thu, 1 Nov 2001 15:41:07 -0500
Date: Thu, 1 Nov 2001 18:40:35 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Nick LeRoy <nleroy@cs.wisc.edu>
Cc: "Jeffrey W. Baker" <jwbaker@acm.org>, <linux-kernel@vger.kernel.org>
Subject: Re: on exit xterm  totally wrecks linux 2.4.11 to 2.4.14-pre6
 (unkillable processes)
In-Reply-To: <200111012035.fA1KZMG11816@schroeder.cs.wisc.edu>
Message-ID: <Pine.LNX.4.33L.0111011839120.447-100000@duckman.distro.conectiva>
X-supervisor: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Nov 2001, Nick LeRoy wrote:

> Yeah, I think that I know what I'm talking about.  The question
> was:  Should devfs be fixed, or should xterm be fixed.

If any random malicious user can crash the machine through
devfs, I think the answer to this question is quite obvious.

The security hole should be fixed.

Rik
-- 
DMCA, SSSCA, W3C?  Who cares?  http://thefreeworld.net/  (volunteers needed)

http://www.surriel.com/		http://distro.conectiva.com/


