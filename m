Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317778AbSGKHQW>; Thu, 11 Jul 2002 03:16:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317779AbSGKHQV>; Thu, 11 Jul 2002 03:16:21 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:22751 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S317778AbSGKHQU>; Thu, 11 Jul 2002 03:16:20 -0400
Date: Thu, 11 Jul 2002 09:18:59 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Jussi Laako <jussi.laako@kolumbus.fi>
cc: linux-kernel@vger.kernel.org
Subject: Re: [CRASH] in tulip driver?
In-Reply-To: <3D2C92C0.658B954@kolumbus.fi>
Message-ID: <Pine.NEB.4.44.0207110917280.24665-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Jul 2002, Jussi Laako wrote:

> Hello,
>
> Any ideas what is causing the following crash?
>
>
> 	- Jussi Laako
>...
> kernel BUG at sched.c:579!
> invalid operand: 0000
> CPU:    0
> EIP:    0010:[<c01169ac>]    Tainted: P
>...


Which non-free modules (e.g. NVidia) were loaded on your computer?


cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox



