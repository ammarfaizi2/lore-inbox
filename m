Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261617AbVDEIFL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261617AbVDEIFL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 04:05:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261600AbVDEH73
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 03:59:29 -0400
Received: from fire.osdl.org ([65.172.181.4]:10685 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261615AbVDEHwB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 03:52:01 -0400
Date: Tue, 5 Apr 2005 00:51:51 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc2-mm1
Message-Id: <20050405005151.494c0e3e.akpm@osdl.org>
In-Reply-To: <20050405074530.GF26208@infradead.org>
References: <20050405000524.592fc125.akpm@osdl.org>
	<20050405074530.GF26208@infradead.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:
>
> (btw, could you please add to all patches who's responsible for them,
>  bk-audit.patch doesn't tell)

It's supposed to, but if I have to fix rejects and refresh the patch, I
lose that info.  Right now, bk-audit stomps on bk-ia64, so we lost the info.
I'll finally get around to fixing that up right now.

Anyway.  dwmw2.

