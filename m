Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262176AbSJNVAR>; Mon, 14 Oct 2002 17:00:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262162AbSJNVAR>; Mon, 14 Oct 2002 17:00:17 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:13777 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S262176AbSJNU6l> convert rfc822-to-8bit; Mon, 14 Oct 2002 16:58:41 -0400
Date: Mon, 14 Oct 2002 18:26:53 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: DervishD <raul@pleyades.net>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mmap.c (do_mmap_pgoff), against 2.4.19 and 2.4.20-pre10
In-Reply-To: <20021014093622.GA96@DervishD>
Message-ID: <Pine.LNX.4.44L.0210141825410.32616-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Since I do not consider this to be critical, I _will_ apply it on
2.4.21-pre.

At that time, resend me without the addition of the comment.

Thanks and sorry for being so unresponsive

On Mon, 14 Oct 2002, DervishD wrote:

>     Hi all, specially Marcelo :)
>
>     This is the fourth and last time I submit this patch to Marcelo.
> This little tiny bug is fixed in all trees except the official one. I
> think this patch is trivial enough to be accepted, but...
>
>     Well, the attachments included (unified diff format), is the patch
> against both 2.4.19 and 2.4.20-pre10 (I've changed the kernel name
> directory part to '/usr/src/linux/' so it's applicable to both
> versions.
>
>     Marcelo, if you don't want to include this patch at least let me
> know, please, so I won't need to see each new prerelease for seeing
> if the patch has been already included ;))) Don't take it bad.
>
>     Raúl
>

