Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275098AbRJQJT1>; Wed, 17 Oct 2001 05:19:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275126AbRJQJTR>; Wed, 17 Oct 2001 05:19:17 -0400
Received: from [195.63.194.11] ([195.63.194.11]:35341 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S275098AbRJQJTA>; Wed, 17 Oct 2001 05:19:00 -0400
Message-ID: <3BCD4BA4.B32E9F81@evision-ventures.com>
Date: Wed, 17 Oct 2001 11:13:08 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-12 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Jesper Juhl <juhl@eisenstein.dk>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] various minor cleanups against 2.4.13-pre3 - comments 
 requested
In-Reply-To: <3BCC8C88.58BBCC39@eisenstein.dk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl wrote:

> kernel/panic.c : panic()
>         There's a small typo in the text that's printk()'d to the user - it
> says "...the boot prom\n" where I believe it should say "...the boot
> prompt\n".

No I think it should be as it is... prom - measn here boot programm read
only memmory.
Somethink like the bios on other architecutres then x86.
