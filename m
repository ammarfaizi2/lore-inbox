Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264098AbUHAAkL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264098AbUHAAkL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jul 2004 20:40:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264113AbUHAAkL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jul 2004 20:40:11 -0400
Received: from fw.osdl.org ([65.172.181.6]:61322 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264098AbUHAAkH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jul 2004 20:40:07 -0400
Date: Sat, 31 Jul 2004 17:38:32 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: linux-kernel@vger.kernel.org, acme@conectiva.com.br
Subject: Re: [PATCH] drivers/net/wan/cycx_x25.c:189: warning: conflicting
 types for built-in function 'log2'
Message-Id: <20040731173832.451d4e9e.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.60.0408010225180.2660@dragon.hygekrogen.localhost>
References: <Pine.LNX.4.60.0408010225180.2660@dragon.hygekrogen.localhost>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl <juhl-lkml@dif.dk> wrote:
>

Your patches get random rejects.

> Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed

Probably because of the format=flowed braindamage.

I fixed this one up.
