Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316621AbSGYWii>; Thu, 25 Jul 2002 18:38:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316629AbSGYWii>; Thu, 25 Jul 2002 18:38:38 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:10510 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S316621AbSGYWih>; Thu, 25 Jul 2002 18:38:37 -0400
Date: Thu, 25 Jul 2002 19:41:39 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Andrea Arcangeli <andrea@suse.de>
cc: Cort Dougan <cort@fsmlabs.com>, Christoph Hellwig <hch@infradead.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cheap lookup of symbol names on oops()
In-Reply-To: <20020725205910.GR1180@dualathlon.random>
Message-ID: <Pine.LNX.4.44L.0207251941120.3086-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Jul 2002, Andrea Arcangeli wrote:

> valuable for what? you need the system.map or the .o disassembly of the
> module anyways to take advantage of such symbol. I don't find it useful.

If you're willing to teach all our users how to use ksymoops ... ;)

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

