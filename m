Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315004AbSDWBUE>; Mon, 22 Apr 2002 21:20:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315005AbSDWBUD>; Mon, 22 Apr 2002 21:20:03 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:2829 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S315004AbSDWBUC>; Mon, 22 Apr 2002 21:20:02 -0400
Date: Mon, 22 Apr 2002 18:19:48 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Brian Gerst <bgerst@didntduck.org>
cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] setup_per_cpu still broken in 2.5.9
In-Reply-To: <3CC4A007.1070307@didntduck.org>
Message-ID: <Pine.LNX.4.44.0204221818170.2170-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 22 Apr 2002, Brian Gerst wrote:
>
> Still broken for UP.  It looks like a patch got applied twice.

Duh.

I _tested_ the damn thing worked, but obviously in between testing and
making a real 2.5.9 another patch did the fix again.

Thanks,

		Linus


