Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131025AbQKRUgz>; Sat, 18 Nov 2000 15:36:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130516AbQKRUgp>; Sat, 18 Nov 2000 15:36:45 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:16380 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S131131AbQKRUgb>; Sat, 18 Nov 2000 15:36:31 -0500
Date: Sat, 18 Nov 2000 18:05:05 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: Francois romieu <romieu@ensta.fr>
cc: Kaj-Michael Lang <milang@tal.org>,
        Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] swap=<device> kernel commandline
In-Reply-To: <20001118141524.A15214@nic.fr>
Message-ID: <Pine.LNX.4.21.0011181804360.9267-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Nov 2000, Francois romieu wrote:
> The Sat, Nov 18, 2000 at 01:46:40PM +0200, Kaj-Michael Lang wrote :
> > This patch adds a swap kernel commandline option, so that you can add a
> > swap partition before init starts running on a low-memory machine. 
                                                   ^^^^^^^^^^

> Did you try and add swap from an initrd image ? It should work
> and it's already there.

Did you try to load an initrd on a low-memory machine?
It shouldn't work and it probably won't ;)

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
