Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267558AbUJDI37@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267558AbUJDI37 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 04:29:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267633AbUJDI37
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 04:29:59 -0400
Received: from fw.osdl.org ([65.172.181.6]:39146 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267558AbUJDI36 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 04:29:58 -0400
Date: Mon, 4 Oct 2004 01:27:31 -0700
From: Andrew Morton <akpm@osdl.org>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: linux-kernel@vger.kernel.org, dev@sw.ru, torvalds@osdl.org
Subject: Re: [PATCH] alternate stack dump fix.
Message-Id: <20041004012731.2634bff8.akpm@osdl.org>
In-Reply-To: <41610845.E03B482D@tv-sign.ru>
References: <41602238.A828A852@tv-sign.ru>
	<20041003100603.6429acdd.akpm@osdl.org>
	<41610845.E03B482D@tv-sign.ru>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@tv-sign.ru> wrote:
>
>  For your convenience, i will post the same patch against mm tree with those
>  3 patches reverted in a separate message.

In that case I'm not understanding you.  Are you saying that your patch
fixes the same problem as that which Kirill's patch fixed?  That wasn't at
all clear from your earlier comments.

If so, please describe precisely what problems your patch fixes, and how.

Thanks.
