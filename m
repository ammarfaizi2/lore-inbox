Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279014AbRJVWZb>; Mon, 22 Oct 2001 18:25:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279011AbRJVWYy>; Mon, 22 Oct 2001 18:24:54 -0400
Received: from deepthought.blinkenlights.nl ([62.58.162.228]:3844 "EHLO
	mail.blinkenlights.nl") by vger.kernel.org with ESMTP
	id <S279007AbRJVWYU>; Mon, 22 Oct 2001 18:24:20 -0400
Date: Tue, 23 Oct 2001 00:39:35 +0200 (CEST)
From: Sten <sten@blinkenlights.nl>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: INIT_MMAP on sparc64
In-Reply-To: <20011021.181523.112610375.davem@redhat.com>
Message-ID: <Pine.LNX.4.40-blink.0110230030150.20416-100000@deepthought.blinkenlights.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Oct 2001, David S. Miller wrote:

>
> DRI works perfectly fine in my current sources, patches below.
>
> Wrt the 3.5MB size limitation, use modules man.

mjes, the kernel module loader is nice, it's just
that I know what hardware I have and like to build
a kernel with what I need.

Ow well. I wonder if the dri driver is as funny as the hme one ;)

-- 

Sten Spans

