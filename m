Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275511AbRJAU2m>; Mon, 1 Oct 2001 16:28:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275506AbRJAU2c>; Mon, 1 Oct 2001 16:28:32 -0400
Received: from net2.ameuro.de ([62.208.90.8]:56288 "EHLO mail2.ameuro.de")
	by vger.kernel.org with ESMTP id <S275504AbRJAU2T>;
	Mon, 1 Oct 2001 16:28:19 -0400
Date: Mon, 1 Oct 2001 22:28:24 +0200
From: Anders Larsen <anders@alarsen.net>
To: Dan Mann <daniel_b_mann@hotmail.com>
Cc: Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: QNX Scheduler patch
Message-ID: <20011001222824.M1948@errol.alarsen.net>
In-Reply-To: <OE309IcVux1Zcn8TtEv00006b70@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <OE309IcVux1Zcn8TtEv00006b70@hotmail.com>; from daniel_b_mann@hotmail.com on Mon, Oct 01, 2001 at 18:19:28 +0200
X-Mailer: Balsa 1.2.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2001-10-01 18:19:28 +0200 Dan Mann wrote:
> Can anyone tell me about experience with the QNX scheduler patch done way
> back for kernel 2.0.31?  I've been wanting to try it on a 2.4 series kernel
> (I'm looking for best possible interactive performance under X), and I want
> to know if it is worth porting to the 2.4 line.

You may wish to take a look at the Linux kernel preemption project at
  http://kpreempt.sourceforge.net/  (official site, patch for 2.4.6)
  http://tech9.net/rml/linux/       (bleeding edge, patch for 2.4.10+)

cheers
  Anders
