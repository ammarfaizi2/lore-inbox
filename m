Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286289AbRLJPlX>; Mon, 10 Dec 2001 10:41:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286288AbRLJPlF>; Mon, 10 Dec 2001 10:41:05 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:10759 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S286289AbRLJPlB>; Mon, 10 Dec 2001 10:41:01 -0500
Date: Mon, 10 Dec 2001 13:40:31 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: <volodya@mindspring.com>, <linux-kernel@vger.kernel.org>
Subject: Re: mm question
In-Reply-To: <E16DSFZ-0002KX-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33L.0112101340030.4755-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Dec 2001, Alan Cox wrote:

> > I was hoping for something more elegant, but I am not adverse to writing
> > my own get_free_page_from_range().
>
> Thats not a trivial task.

Especially because we never quite know the users of a
physical page, so moving data around is somewhat hard.

cheers,

Rik
-- 
DMCA, SSSCA, W3C?  Who cares?  http://thefreeworld.net/

http://www.surriel.com/		http://distro.conectiva.com/

