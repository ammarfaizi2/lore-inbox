Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751233AbWEWBFV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751233AbWEWBFV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 21:05:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751230AbWEWBFV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 21:05:21 -0400
Received: from vbn.0050556.lodgenet.net ([216.142.194.234]:24016 "EHLO
	vbn.0050556.lodgenet.net") by vger.kernel.org with ESMTP
	id S1751233AbWEWBFU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 21:05:20 -0400
Subject: Re: [PATCH] 2.6.16.16 Parameter-controlled mmap/stack randomization
From: Arjan van de Ven <arjan@infradead.org>
To: John Richard Moser <nigelenki@comcast.net>
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
In-Reply-To: <4471E77F.1010704@comcast.net>
References: <446E6A3B.8060100@comcast.net>
	 <1148132838.3041.3.camel@laptopd505.fenrus.org>
	 <446F3483.40208@comcast.net> <20060522010606.GC25434@elf.ucw.cz>
	 <44712605.4000001@comcast.net> <20060522083352.GA11923@elf.ucw.cz>
	 <4471E77F.1010704@comcast.net>
Content-Type: text/plain
Date: Tue, 23 May 2006 03:05:16 +0200
Message-Id: <1148346316.3100.6.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-05-22 at 12:31 -0400, John Richard Moser wrote:
> It is still possible that ARCH_STACK_RANDOM_BITS_DEFAULT breaks things.
>  The current kernel default broke emacs at first I heard;

hearsay.. where did you hear this and what exact randomization was this?


>  I believe we
> started with 64KiB of stack randomization and then upped it to 8MiB when
> emacs was fixed.

this is new information to me, I find this really really hard to believe
as true but maybe you have information I don't have...



