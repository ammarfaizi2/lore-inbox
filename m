Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264038AbRFKU7H>; Mon, 11 Jun 2001 16:59:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264041AbRFKU6t>; Mon, 11 Jun 2001 16:58:49 -0400
Received: from [193.14.164.225] ([193.14.164.225]:19461 "EHLO wlug.westbo.se")
	by vger.kernel.org with ESMTP id <S264038AbRFKU6k>;
	Mon, 11 Jun 2001 16:58:40 -0400
Date: Mon, 11 Jun 2001 23:02:16 +0200 (CEST)
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: Michal Margula <alchemyx@uznam.net.pl>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Disaster under heavy network load on 2.4.x
In-Reply-To: <20010611220301.A6852@cerber.uznam.net.pl>
Message-ID: <Pine.LNX.4.30.0106112300190.27754-100000@wlug.westbo.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Jun 2001, Michal Margula wrote:

> Hello!
>
> My friend told me to noticed you about problems I had with 2.4.x line of
> kernels. I started up from 2.4.3. Under heavy load I was getting
> messages from telnet, ping, nmap "No buffer space available". Strace
> told me it was error marked as ENOBUFS.
>
> First thought was it was my fault. I asked many people and nobody could
> help me. So I tried 2.4.5. It was a disaster also (should I mention few
> oopses?:>).

Would you mind running those Oopses through ksymoops and send the
backtraces to this list?

/Martin

-- 
Linux hackers are funny people: They count the time in patchlevels.

