Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267793AbUJJAPL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267793AbUJJAPL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 20:15:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267810AbUJJAPL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 20:15:11 -0400
Received: from mail.dif.dk ([193.138.115.101]:39894 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S267793AbUJJAPG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 20:15:06 -0400
Date: Sun, 10 Oct 2004 02:22:44 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] check copy_to_user return value in raw1394
In-Reply-To: <Pine.LNX.4.61.0410100208270.2973@dragon.hygekrogen.localhost>
Message-ID: <Pine.LNX.4.61.0410100220580.2973@dragon.hygekrogen.localhost>
References: <Pine.LNX.4.61.0410100208270.2973@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Oct 2004, Jesper Juhl wrote:

> 
> Here's a proposed patch to make sure we check the return value of 
> copy_to_user in raw1394.c::raw1394_read


Whoops, I made an error when I set the From: address on this mail. If you 
reply to this then please use juhl-lkml as the address if you want me to 
see your reply.

--
Jesper Juhl <juhl-lkml@dif.dk>



