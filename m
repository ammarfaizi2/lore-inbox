Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261645AbSJOTfY>; Tue, 15 Oct 2002 15:35:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263193AbSJOTfY>; Tue, 15 Oct 2002 15:35:24 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:15549 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S261645AbSJOTfX>; Tue, 15 Oct 2002 15:35:23 -0400
Date: Tue, 15 Oct 2002 17:03:42 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: john stultz <johnstul@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] compile fix for dmi_scan.c in 2.4.bk-current
In-Reply-To: <1034707631.19094.178.camel@cog>
Message-ID: <Pine.LNX.4.44L.0210151702500.11036-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 15 Oct 2002, john stultz wrote:

> On Tue, 2002-10-15 at 11:40, john stultz wrote:
> > I'm not sure if its the "proper" fix, but solves:
>
> Actually, I'm sure that's not the right fix.
> In fact its pretty horribly broken as well.
>
> Sorry, next time I'll actually look at what I'm doing before mailing.

I'll remove the dmi update from Alan for 2.4.20-pre.

Thats a 2.4.21-pre thing.

