Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261767AbSI2U2C>; Sun, 29 Sep 2002 16:28:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261775AbSI2U2C>; Sun, 29 Sep 2002 16:28:02 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:22232 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S261767AbSI2U1u>; Sun, 29 Sep 2002 16:27:50 -0400
Date: Sun, 29 Sep 2002 22:33:05 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Christoph Hellwig <hch@sgi.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix drm ioctl ABI default
In-Reply-To: <1033153674.16726.10.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.NEB.4.44.0209292224590.12605-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 Sep 2002, Alan Cox wrote:

> With all the vendors now shipping 4.2 this seems a bad thing to default
> to the 4,1 interface - especially as the 4.1 server is
>...

Debian 3.0 ships with 4.1 and my personal estimation is that the next
release of Debian will be in 2004 (I'm happy if it will be earlier...).

> o Has security holes that are fixed in 4.2.1 only

The Debian maintainer of XFree86 claims that at least the Xlib problem
doesn't affect 4.1 [1].

> Alan

cu
Adrian

[1] http://people.debian.org/~branden/

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox

