Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315440AbSGQRI6>; Wed, 17 Jul 2002 13:08:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315442AbSGQRI6>; Wed, 17 Jul 2002 13:08:58 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:4077 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S315440AbSGQRI4>; Wed, 17 Jul 2002 13:08:56 -0400
Date: Wed, 17 Jul 2002 19:11:49 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: "Justin M. Forbes" <kernelmail@attbi.com>
cc: marcelo@conectiva.com.br, <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.19-rc2 compile fail
In-Reply-To: <Pine.LNX.4.44.0207170701590.30348-200000@leaper.linuxtx.org>
Message-ID: <Pine.NEB.4.44.0207171902230.16056-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Jul 2002, Justin M. Forbes wrote:

>  GCC version is 3.1 .config is attached, fairly large as I base it off of
> the original Red Hat one to make sure everything compiles, even though I
> am not using most of it. Strangely no compile problems on my base 7.2 box
> (gcc 2.96).  .config is attached.

The short answer ist perhaps: 3.1 is not a supported compiler...

But I'm surprised that I wasn't able to reproduce it using the 20020703
(past 3.1) snapshot of the gcc-3.1 branch that is in Debian unstable.

> Justin M. Forbes

cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox


