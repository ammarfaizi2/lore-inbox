Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317258AbSINPCu>; Sat, 14 Sep 2002 11:02:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317331AbSINPCu>; Sat, 14 Sep 2002 11:02:50 -0400
Received: from 2-028.ctame701-1.telepar.net.br ([200.193.160.28]:38877 "EHLO
	2-028.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S317258AbSINPCu>; Sat, 14 Sep 2002 11:02:50 -0400
Date: Sat, 14 Sep 2002 12:07:12 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Hans-Peter Jansen <hpj@urpla.net>
cc: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Good way to free as much memory as possible under 2.5.34?
In-Reply-To: <200209141651.00974.hpj@urpla.net>
Message-ID: <Pine.LNX.4.44L.0209141206270.1857-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 Sep 2002, Hans-Peter Jansen wrote:

> The question is: why is the VM not able to fulfill such a simple need in
> a clean way?

No. The question is: "why does swsuspend need to stick its fingers
into every other subsystem of the kernel, instead of trying to
remain vaguely modular ?"

If you have an answer, please let me know.

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

Spamtraps of the month:  september@surriel.com trac@trac.org

