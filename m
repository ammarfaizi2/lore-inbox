Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318775AbSG0PoC>; Sat, 27 Jul 2002 11:44:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318776AbSG0PoB>; Sat, 27 Jul 2002 11:44:01 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:26637 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S318775AbSG0PoA>; Sat, 27 Jul 2002 11:44:00 -0400
Date: Sat, 27 Jul 2002 12:47:05 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Ville Herva <vherva@niksula.hut.fi>
cc: DervishD <raul@pleyades.net>, Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: About the need of a swap area
In-Reply-To: <20020727144228.GQ1548@niksula.cs.hut.fi>
Message-ID: <Pine.LNX.4.44L.0207271246040.3086-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Jul 2002, Ville Herva wrote:

> cache. This can help tremendously, since RAM is ~1000 times faster than
> harddisk.

Much more.

The latency difference seems to be on the order of 100000 times.
It is the latency we care about because that determines how long
the CPU cannot do anything useful but has to wait.

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

