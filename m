Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318742AbSG0MLi>; Sat, 27 Jul 2002 08:11:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318743AbSG0MLi>; Sat, 27 Jul 2002 08:11:38 -0400
Received: from 212.Red-80-35-44.pooles.rima-tde.net ([80.35.44.212]:4224 "EHLO
	DervishD.pleyades.net") by vger.kernel.org with ESMTP
	id <S318742AbSG0MLh>; Sat, 27 Jul 2002 08:11:37 -0400
Date: Sat, 27 Jul 2002 14:22:20 +0200
Organization: Pleyades
To: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: About the need of a swap area
Message-ID: <3D42907C.mailFS15JQVA@viadomus.com>
User-Agent: nail 9.31 6/18/02
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
From: DervishD <raul@pleyades.net>
Reply-To: DervishD <raul@pleyades.net>
X-Mailer: DervishD TWiSTiNG Mailer
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi all :))

    I read a time ago that, no matter the RAM you have, adding a
swap-area will improve performance a lot. So I tested.

    I created a swap area twice as large as my RAM size (just an
arbitrary size), that is 1G. I've tested with lower sizes too. My RAM
is never filled (well, I haven't seen it filled, at least) since I
always work on console, no X and things like those. Even compiling
two or three kernels at a time don't consume my RAM. What I try to
explain is that the swap is not really needed in my machine, since
the memory is not prone to be filled.

    Well, I haven't notice any change in performance, and the swap
area is *never* used. That contradicts what I've read about that, no
matter your free RAM size, a bit of swap is always used. That is not
my case, definitely.

    So my question is: should I use a swap-area for improving
performance (or whatever else), or should I use those precious bytes
to improving my porn collection }:))? Seriously: I don't understand
how the swap works, I don't know if the swap area is used only when
RAM is exhausted or when the free RAM goes low beyond some point,
etc... I've read (just took a look) the kernel archives about swap
and it haven't light me O:))

    Thanks a lot :)
    Raúl
