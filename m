Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751324AbWBZVOx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751324AbWBZVOx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 16:14:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751408AbWBZVOx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 16:14:53 -0500
Received: from relay02.mail-hub.dodo.com.au ([202.136.32.45]:65002 "EHLO
	relay02.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S1751324AbWBZVOw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 16:14:52 -0500
From: Grant Coady <gcoady@gmail.com>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Sam Ravnborg <sam@ravnborg.org>
Subject: Re: Building 100 kernels; we suck at dependencies and drown in warnings
Date: Mon, 27 Feb 2006 08:14:43 +1100
Organization: http://bugsplatter.mine.nu/
Reply-To: gcoady@gmail.com
Message-ID: <336402hq8014pc1cg8169f8tumhj302vho@4ax.com>
References: <200602261721.17373.jesper.juhl@gmail.com>
In-Reply-To: <200602261721.17373.jesper.juhl@gmail.com>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Feb 2006 17:21:17 +0100, Jesper Juhl <jesper.juhl@gmail.com> wrote:

>
>Hi everyone,
>
>I just sat down and build 100 kernels (2.6.16-rc4-mm2 kernels to be exact)
>
>	95 kernels were build with 'make randconfig'.
>	1 kernel was build with the config I normally use for my own box.
>	1 kernel was build from 'make defconfig'.
>	1 kernel was build from 'make allmodconfig'.
>	1 kernel was build from 'make allnoconfig'.
>	1 kernel was build from 'make allyesconfig'.
>
>That was an interresting experience. 

Welcome to the club ;)  I gave up make randconfig months ago as 
there's simply too much noise in there...  There are same errors 
popping up for months now without resolution, and I lack experience 
to fix most things I see -- asked akpm once but not grok Andrew's 
response (months ago).

But is it summer here and I don't do much testing in hot weather.

Grant.
