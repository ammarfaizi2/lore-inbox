Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S132347AbQKZRad>; Sun, 26 Nov 2000 12:30:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132435AbQKZRaX>; Sun, 26 Nov 2000 12:30:23 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:32754 "EHLO
        brutus.conectiva.com.br") by vger.kernel.org with ESMTP
        id <S132347AbQKZRaN>; Sun, 26 Nov 2000 12:30:13 -0500
Date: Sun, 26 Nov 2000 14:58:50 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: Olaf Dietsche <olaf.dietsche@gmx.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: gcc-2.95.2-51 is buggy
In-Reply-To: <87ofz2lpdm.fsf@tigram.bogus.local>
Message-ID: <Pine.LNX.4.21.0011261458290.23375-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 26 Nov 2000, Olaf Dietsche wrote:

> A simple `gcc -march=i686' or `gcc -mpentiumpro' does fix it as
> well. So, if you configure your kernel with `CONFIG_M686=y' the
> problem should be gone.

Except for the fact that it'll no longer boot on Pentiums
and 486es ;)

Rik
--
Hollywood goes for world dumbination,
	Trailer at 11.

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
