Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286998AbRL1Tjb>; Fri, 28 Dec 2001 14:39:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286993AbRL1TjV>; Fri, 28 Dec 2001 14:39:21 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:57105 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S286995AbRL1TjI>; Fri, 28 Dec 2001 14:39:08 -0500
Date: Fri, 28 Dec 2001 17:38:46 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: <rhw@MemAlpha.cx>, Andreas Dilger <adilger@turbolabs.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] unchecked request_region's in drivers/net
In-Reply-To: <E16K23q-0001OG-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33L.0112281738140.12225-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Dec 2001, Alan Cox wrote:

> > currently is, but add a PATCHES-TO file in each subdirectory that
> > states how to handle patches relating to that directory, and have
> > these files follow a strict format, possibly...
>
> Add the patches to to the maintainers as another field. If the patches
> go to someone who isnt claiming to be a maintainer something is wrong

We'll have to educate viro, then.  I bet he won't like it
if VFS patches don't get send to him, but he's not listed
as a maintainer ...

Rik
-- 
DMCA, SSSCA, W3C?  Who cares?  http://thefreeworld.net/

http://www.surriel.com/		http://distro.conectiva.com/

