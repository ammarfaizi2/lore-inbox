Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750771AbVIQAF4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750771AbVIQAF4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 20:05:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750807AbVIQAF4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 20:05:56 -0400
Received: from smtp.osdl.org ([65.172.181.4]:49064 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750771AbVIQAFz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 20:05:55 -0400
Date: Fri, 16 Sep 2005 17:05:22 -0700
From: Andrew Morton <akpm@osdl.org>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Fix epoll delayed initialization bug ...
Message-Id: <20050916170522.7d374e69.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.63.0509161655240.6125@localhost.localdomain>
References: <Pine.LNX.4.63.0509161621050.6125@localhost.localdomain>
	<20050916165053.2dec0a6b.akpm@osdl.org>
	<Pine.LNX.4.63.0509161655240.6125@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi <davidel@xmailserver.org> wrote:
>
>  > Sigh.  Space-stuffing strikes again.  Please resend as an attachment.
>  >
>  > The number of whitespace-buggered patches which are coming in is just
>  > getting out of control lately.
>  >
>  > Even `patch -l' tossed four rejects, so there may be something else wrong
>  > in this one.
> 
>  My side or your side?

Not mine, pal ;)

Although sylpheed could perhaps do a better job of decrypting some of the
oddities which arrive.

> Anyway, see if the one attached merges cleanly ...

It does.
