Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262061AbSITJtU>; Fri, 20 Sep 2002 05:49:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262066AbSITJtU>; Fri, 20 Sep 2002 05:49:20 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:39893 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S262061AbSITJtS>; Fri, 20 Sep 2002 05:49:18 -0400
Date: Fri, 20 Sep 2002 11:54:20 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Ulrich Drepper <drepper@redhat.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] Native POSIX Thread Library 0.1
In-Reply-To: <3D8A6EC1.1010809@redhat.com>
Message-ID: <Pine.NEB.4.44.0209201144270.2586-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Sep 2002, Ulrich Drepper wrote:

>...
> Unless major flaws in the design are found this code is intended to
> become the standard POSIX thread library on Linux system and it will
> be included in the GNU C library distribution.
>...
> - - requires a kernel with the threading capabilities of Linux 2.5.36.
>...


My personal estimation is that Debian will support kernel 2.4 in it's
stable distribution until 2006 or 2007 (this is based on the experience
that Debian usually supports two stable kernel series and the time between
stable releases of Debian is > 1 year). What is the proposed way for
distributions to deal with this?


cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox


