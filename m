Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316170AbSEWKHo>; Thu, 23 May 2002 06:07:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316375AbSEWKHn>; Thu, 23 May 2002 06:07:43 -0400
Received: from bart.one-2-one.net ([217.115.142.76]:17157 "EHLO
	bart.one-2-one.net") by vger.kernel.org with ESMTP
	id <S316170AbSEWKHm>; Thu, 23 May 2002 06:07:42 -0400
Date: Thu, 23 May 2002 12:10:29 +0200 (CEST)
From: Martin Diehl <lists@mdiehl.de>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Martin Dalecki <dalecki@evision-ventures.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.17 /dev/ports
In-Reply-To: <Pine.LNX.4.44.0205220925120.7580-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.21.0205231054180.7479-100000@notebook.diehl.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 May 2002, Linus Torvalds wrote:

> Anybody: if you've ever used /dev/ports, holler _now_.

For me, "hexedit /dev/port" turned out being a pretty helpful tool for
simple hardware analysis. Besides playing what-if games it's also
sometimes useful for driver testing to trigger certain paths for example.

Wouldn't it be worth keeping it opt-in (like CONFIG_NVRAM e.g.)?

Martin

