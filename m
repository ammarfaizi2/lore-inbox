Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317907AbSHHUBZ>; Thu, 8 Aug 2002 16:01:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317935AbSHHUBY>; Thu, 8 Aug 2002 16:01:24 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:64775 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S317907AbSHHUBX>; Thu, 8 Aug 2002 16:01:23 -0400
Date: Thu, 8 Aug 2002 17:04:42 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@duckman.distro.conectiva
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Announce: daily 2.5 BK snapshots
In-Reply-To: <3D52CC12.9090909@mandrakesoft.com>
Message-ID: <Pine.LNX.4.44L.0208081703260.2589-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Aug 2002, Jeff Garzik wrote:

> Since Linus does not do pre-patches anymore, he mentioned some time ago
> it would be nice if somebody created an automated BK snapshot process to
> make BK changes accessible between kernel releases.  I've done that.
>
> ftp://ftp.kernel.org/pub/linux/kernel/people/jgarzik/snap/2.5/

> Questions and comments welcome.

Heh, I've had something vaguely like this on NL.linux.org:

ftp://ftp.nl.linux.org/pub/linux/bk2patch/

Every 3 hours it creates a unidiff between the latest
tagged version and the head of the bk tree, for both 2.5
and 2.4.

cheers,

Rik
-- 
	http://www.linuxsymposium.org/2002/
"You're one of those condescending OLS attendants"
"Here's a nickle kid.  Go buy yourself a real t-shirt"

http://www.surriel.com/		http://distro.conectiva.com/

