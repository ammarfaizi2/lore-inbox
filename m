Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282508AbRLFSlB>; Thu, 6 Dec 2001 13:41:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282418AbRLFSkF>; Thu, 6 Dec 2001 13:40:05 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:28686 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S282495AbRLFSjF>; Thu, 6 Dec 2001 13:39:05 -0500
Date: Thu, 6 Dec 2001 16:38:46 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Cc: Pablo Borges <pablo.borges@uol.com.br>, <linux-kernel@vger.kernel.org>
Subject: Re: Kernel 2.4.16 & Heavy I/O
In-Reply-To: <Pine.LNX.4.30.0112061908220.17427-100000@mustard.heime.net>
Message-ID: <Pine.LNX.4.33L.0112061638310.2283-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Dec 2001, Roy Sigurd Karlsbakk wrote:

> Is it really neccecary? Free memory's a waste! The cache will be
> discarded the moment an application needs the memory.

That's not the case with use-once ...

Rik
-- 
DMCA, SSSCA, W3C?  Who cares?  http://thefreeworld.net/

http://www.surriel.com/		http://distro.conectiva.com/

