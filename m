Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263963AbTKJQtV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 11:49:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263969AbTKJQtV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 11:49:21 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:46984 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S263963AbTKJQtU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 11:49:20 -0500
X-AuthUser: davidel@xmailserver.org
Date: Mon, 10 Nov 2003 08:49:20 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Andrea Arcangeli <andrea@suse.de>
cc: Larry McVoy <lm@bitmover.com>, "H. Peter Anvin" <hpa@zytor.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel.bkbits.net off the air
In-Reply-To: <20031110132617.GA6834@x30.random>
Message-ID: <Pine.LNX.4.44.0311100844190.1821-100000@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Nov 2003, Andrea Arcangeli wrote:

> same here, however the rsync export on kernel.org is lacking a two
> sequence number locking that would allow us to checkout a coherent copy
> of the cvs repository.  Currently it works by luck.

Peter, how the current rsync BKCVS root is updated at kernel.org? Is 
coherency guaranteed in some way?



- Davide


