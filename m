Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261830AbVGUSdk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261830AbVGUSdk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 14:33:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261841AbVGUSdk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 14:33:40 -0400
Received: from pne-smtpout1-sn1.fre.skanova.net ([81.228.11.98]:23483 "EHLO
	pne-smtpout1-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S261830AbVGUSdk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 14:33:40 -0400
Date: Thu, 21 Jul 2005 20:33:27 +0200
From: Voluspa <lista1@telia.com>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc3 Battery times at 100/250/1000 Hz = Zero difference
Message-Id: <20050721203327.2f82eed8.lista1@telia.com>
In-Reply-To: <9a8748490507211114227720b0@mail.gmail.com>
References: <20050721200448.5c4a2ea0.lista1@telia.com>
	<9a8748490507211114227720b0@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Jul 2005 20:14:32 +0200 Jesper Juhl wrote:
> On 7/21/05, Voluspa <lista1@telia.com> wrote:
[...]
> > 
> Ok, so with an idle machine, different HZ makes no noticeable
> difference, but I'd suspect things would be different if the machine
> was actually doing some work.

I first thought about loading with a loop of md5sum /somedir, play a
wav, fetch a couple of webpages etc. But since the talk has been that
the powersave would come from CPU sleep between "ticks" (I know, I know,
it's not ticks) not having to wake up so often, I decided against a
load.

> Would be more interresting to see how long it lasts with a light load
> and with a heavy load.

I won't do that unless heavily beaten ;-) The battery charge time is
2h10 minutes...

Mvh
Mats Johannesson
--
