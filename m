Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266236AbUJETmE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266236AbUJETmE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 15:42:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266200AbUJETl5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 15:41:57 -0400
Received: from mail.dif.dk ([193.138.115.101]:60618 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S265970AbUJETiv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 15:38:51 -0400
Date: Tue, 5 Oct 2004 21:46:18 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: "Johnson, Richard" <rjohnson@analogic.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux-2.6.5-1.358 and Fedora
In-Reply-To: <1097004565.9975.25.camel@laptop.fenrus.com>
Message-ID: <Pine.LNX.4.61.0410052140150.2913@dragon.hygekrogen.localhost>
References: <1097004565.9975.25.camel@laptop.fenrus.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Oct 2004, Arjan van de Ven wrote:

> If Richard overwrote his modules anyway he must have hacked the Makefile
> himself to deliberately cause this, at which point... well saw wind
> harvest storm ;)
> 
While I lack specific Fedora knowledge and thus can't provide exact 
details for it I'd say it should still be pretty simple to recover. On 
Slackware I'd simply boot a kernel from the install CD and tell it to 
mount the installed system on my HD, then you'll have a running system and 
can easily clean out the broken modules etc and install the original ones 
from your CD and be right back where you started in 5 min. Surely 
something similar is possible with Fedora, reinstalling from scratch (as 
he said he did) seems like massive overkill to me.


--
Jesper Juhl


