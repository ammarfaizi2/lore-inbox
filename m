Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313206AbSDTXPC>; Sat, 20 Apr 2002 19:15:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313217AbSDTXPB>; Sat, 20 Apr 2002 19:15:01 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:23051 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S313206AbSDTXO6>; Sat, 20 Apr 2002 19:14:58 -0400
Date: Sat, 20 Apr 2002 16:14:43 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andi Kleen <ak@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove BK docs ... + x86-64 2.5.8 sync
In-Reply-To: <20020420214420.A13635@wotan.suse.de>
Message-ID: <Pine.LNX.4.44.0204201614000.3643-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 20 Apr 2002, Andi Kleen wrote:
>
> What clash was there? (just curious) I just checked and at least the
> kernel.org finger still shows 2.5.8 as the latest released kernel.

The x86-64 vmlinux.lds thing got a reject. And yes, I tested against clean
2.5.8..

			Linus

