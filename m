Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270079AbUJVIQk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270079AbUJVIQk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 04:16:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269600AbUJVINv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 04:13:51 -0400
Received: from mail.dif.dk ([193.138.115.101]:20916 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S269749AbUJSQfS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 12:35:18 -0400
Date: Tue, 19 Oct 2004 18:43:18 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: "T. Weyergraf" <kirk@colinet.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: patch-2.6.9 against 2.6.8.1
In-Reply-To: <200410190723.i9J7NNuv027374@hydra.colinet.de>
Message-ID: <Pine.LNX.4.61.0410191840310.2932@dragon.hygekrogen.localhost>
References: <200410190723.i9J7NNuv027374@hydra.colinet.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Oct 2004, T. Weyergraf wrote:

> Hi all,
> 
> I just build 2.6.9 using the patch-2.6.9, as always. Previously,
> I was using 2.6.8.1 and i expected patch-2.6.9 to work on the
> 2.6.8.1 tree.

No, it applies to 2.6.8. The situation could arise that a 2.6.8.2 is 
released _after_ 2.6.9 and then having the 2.6.9 patch based on 2.6.8.1 
would be quite confusing.
Read all of this thread for the full story: 
http://www.ussg.iu.edu/hypermail/linux/kernel/0408.3/0293.html


--
Jesper Juhl

