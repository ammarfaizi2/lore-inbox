Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315287AbSEYU23>; Sat, 25 May 2002 16:28:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315293AbSEYU22>; Sat, 25 May 2002 16:28:28 -0400
Received: from gjs.xs4all.nl ([213.84.2.78]:11065 "EHLO mail.gjs.cc")
	by vger.kernel.org with ESMTP id <S315287AbSEYU22>;
	Sat, 25 May 2002 16:28:28 -0400
Content-Type: text/plain; charset=US-ASCII
From: GertJan Spoelman <kl@gjs.cc>
To: Michail Rusinov <one@da.ru>, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: PS/2 keyboard doesn't word with kernel 2.5.17
Date: Sat, 25 May 2002 22:28:22 +0200
User-Agent: KMail/1.4.1
In-Reply-To: <4710249027.20020525214701@da.ru> <1313922740.20020526005224@da.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200205252228.22106.kl@gjs.cc>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 25 May 2002 21:52, Michail Rusinov wrote:
> Hello.
>
> I tried kernel 2.5.17, and I can't get my PS/2 keyboard to work with
> it. After booting, i can see login prompt, can move my mouse, but I can't
> write anything with my keyboard.
> I used kernel 2.4.18 before, and everything was fine.
> I have Soltek's motherboard (SL-75DRV4 on VIA KT266A).
>
> Maybe it's my fault, but I tried everything and can't get my keyboard
> work.
>
> If you need more information about my system, write it.

Did you turn on the Keyboard interface?, you can find it in the Input device 
support section under Input core support.
-- 

    GertJan
