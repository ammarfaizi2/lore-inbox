Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130107AbQKVTyg>; Wed, 22 Nov 2000 14:54:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130078AbQKVTyR>; Wed, 22 Nov 2000 14:54:17 -0500
Received: from [203.36.158.121] ([203.36.158.121]:29958 "HELO kabuki.eyep.net")
        by vger.kernel.org with SMTP id <S129688AbQKVTyF>;
        Wed, 22 Nov 2000 14:54:05 -0500
To: Rik van Riel <riel@conectiva.com.br>
cc: linux-kernel@vger.kernel.org
Subject: Re: Rik's bad process killer - how to kill _IT_? 
In-Reply-To: Your message of "Wed, 22 Nov 2000 12:07:48 -0200."
             <Pine.LNX.4.21.0011221205320.12459-100000@duckman.distro.conectiva> 
In-Reply-To: <Pine.LNX.4.21.0011221205320.12459-100000@duckman.distro.conectiva> 
Date: Thu, 23 Nov 2000 06:25:59 +1100
From: Daniel Stone <daniel@kabuki.eyep.net>
Message-Id: <20001122195415Z129688-8303+149@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Daniel Stone
> > Linux Kernel Developer
>   ^^^^^^^^^^^^^^^^^^^^^^
> 
> If you were, you'd have written something that makes sense.

Touche. I didn't claim to be a Linus, but I have got a few things in the
kernel (sb16 driver, netfilter). Plus you can't ask much when I've gone 5
days without sleep just studying. Better than being kicked out of #Linux
(Undernet) for trolling, though.
 
> 1. my OOM killer *always* spits out a message when it kills
>    something

3 other people have pointed this out to me.

> 2. you haven't written what kernel version you're using;
>    judging from your lack of error messages you're running
>    2.2 (which has the nasty habit of killing processes under
>    heavy load ... I have a patch out which fixes that)

2.4.0-test11.


--
Daniel Stone
Linux Kernel Developer
daniel@kabuki.eyep.net

-----BEGIN GEEK CODE BLOCK-----
Version: 3.1
G!>CS d s++:- a---- C++ ULS++++$>B P---- L+++>++++ E+(joe)>+++ W++ N->++ !o
K? w++(--) O---- M- V-- PS+++ PE- Y PGP>++ t--- 5-- X- R- tv-(!) b+++ DI+++ 
D+ G e->++ h!(+) r+(%) y? UF++
------END GEEK CODE BLOCK------
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
