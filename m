Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264726AbUIFVEZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264726AbUIFVEZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 17:04:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265093AbUIFVEZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 17:04:25 -0400
Received: from fw.osdl.org ([65.172.181.6]:26562 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264726AbUIFVEY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 17:04:24 -0400
Date: Mon, 6 Sep 2004 14:02:09 -0700
From: Andrew Morton <akpm@osdl.org>
To: Hirokazu Takata <takata@linux-m32r.org>
Cc: hch@infradead.org, linux-kernel@vger.kernel.org, takata@linux-m32r.org
Subject: Re: [PATCH 2.6.9-rc1-mm3] [m32r] Modify sys_ipc() to remove useless
 iBCS2 support code
Message-Id: <20040906140209.05416fe6.akpm@osdl.org>
In-Reply-To: <20040906.214051.336469534.takata.hirokazu@renesas.com>
References: <20040903014811.6247d47d.akpm@osdl.org>
	<20040903105423.A3179@infradead.org>
	<20040906.214051.336469534.takata.hirokazu@renesas.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hirokazu Takata <takata@linux-m32r.org> wrote:
>
> The useless iBCS2 supporting code is removed.

I didn't really understand what Christoph was saying about this one, so
I'll apply it for now.

Were you planning to address Christoph's earlier review comments?  One of
which was that the m32r-specific drivers are in the wrong directory? 
Please do.
