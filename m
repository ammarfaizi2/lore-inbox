Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129061AbQKOQyA>; Wed, 15 Nov 2000 11:54:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129860AbQKOQxu>; Wed, 15 Nov 2000 11:53:50 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:41202 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129061AbQKOQxi>; Wed, 15 Nov 2000 11:53:38 -0500
Date: Wed, 15 Nov 2000 14:23:24 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: Andreas Osterburg <alanos@first.gmd.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Swapping over NFS in Linux 2.4?
In-Reply-To: <00111517064807.29351@bar>
Message-ID: <Pine.LNX.4.21.0011151421580.5584-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Nov 2000, Andreas Osterburg wrote:

> Because I set up a diskless Linux-workstation, I want to swap
> over NFS. For this purpose I found only patches for "older"
> Linux-versions (2.0, 2.1, 2.2?).

> Does anyone know wheter there are patches for 2.4 or does anyone
> know another solution for this problem?

1. you can swap over NBD
2. if you point me to the swap-over-nfs patches you
   have found, I can try to make them work on 2.4 ;)

[I have some interest in making swap-over-nfs work and
most of the other VM things in 2.4 are already pretty
stable ... at the moment stability is more important
than extra performance tricks to me]

regards,


Rik
--
"What you're running that piece of shit Gnome?!?!"
       -- Miguel de Icaza, UKUUG 2000

http://www.conectiva.com/		http://www.surriel.com/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
