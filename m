Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129226AbQLKT7Z>; Mon, 11 Dec 2000 14:59:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129387AbQLKT7P>; Mon, 11 Dec 2000 14:59:15 -0500
Received: from coffee.psychology.McMaster.CA ([130.113.218.59]:3356 "EHLO
	coffee.psychology.mcmaster.ca") by vger.kernel.org with ESMTP
	id <S129226AbQLKT7B>; Mon, 11 Dec 2000 14:59:01 -0500
Date: Mon, 11 Dec 2000 14:28:11 -0500 (EST)
From: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>
To: stewart@neuron.com
cc: linux-kernel@vger.kernel.org
Subject: Re: kapm-idled : is this a bug?
In-Reply-To: <Pine.LNX.4.10.10012111343570.2897-100000@localhost>
Message-ID: <Pine.LNX.4.10.10012111426110.23417-100000@coffee.psychology.mcmaster.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Technical merits and voter intent aside, this behavior is misleading and
> inconsistent with previous kernels. Tools like top or a CPU dock applet show

the goal of kernel revision is *not* to remain consistent with old stuff.

> a constantly loaded CPU. Hacking them to deduct the load from 'kapm-idled'
> seems like the wrong answer.

so don't run APM already.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
