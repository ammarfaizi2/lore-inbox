Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261787AbSI2UPG>; Sun, 29 Sep 2002 16:15:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261788AbSI2UPF>; Sun, 29 Sep 2002 16:15:05 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:36312 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S261787AbSI2UPF>; Sun, 29 Sep 2002 16:15:05 -0400
Date: Sun, 29 Sep 2002 22:20:21 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Andi Kleen <ak@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Use __attribute__((malloc)) for gcc 3.2
In-Reply-To: <p733crssjdl.fsf@oldwotan.suse.de>
Message-ID: <Pine.NEB.4.44.0209292219280.12605-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 29 Sep 2002, Andi Kleen wrote:

>...
> I will move it into linux/compiler.h to add some more clutter to include hell,
> because it requires even more #include <linux/compiler.h>
>...

kernel.h includes compiler.h so it shouldn't make a difference.

> -Andi

cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox

