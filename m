Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261761AbVFFWZS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261761AbVFFWZS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 18:25:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261757AbVFFWXD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 18:23:03 -0400
Received: from fire.osdl.org ([65.172.181.4]:18329 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261731AbVFFWVU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 18:21:20 -0400
Date: Mon, 6 Jun 2005 15:21:59 -0700
From: Andrew Morton <akpm@osdl.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] get_user_pages: kill get_page_map
Message-Id: <20050606152159.7863f317.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0506062054170.5000@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0506062054170.5000@goblin.wat.veritas.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins <hugh@veritas.com> wrote:
>
> Oh, and could we please call that "struct page *page" like
> everywhere else, instead of "struct page *map"?

metoo.
