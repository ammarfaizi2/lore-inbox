Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261679AbUJYGh7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261679AbUJYGh7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 02:37:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261675AbUJYG3r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 02:29:47 -0400
Received: from fw.osdl.org ([65.172.181.6]:32449 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261572AbUJYG0z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 02:26:55 -0400
Date: Sun, 24 Oct 2004 23:24:43 -0700
From: Andrew Morton <akpm@osdl.org>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: hugh@veritas.com, andrea@novell.com, albert@users.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] statm: shared = rss - anon_rss
Message-Id: <20041024232443.1a18eb44.akpm@osdl.org>
In-Reply-To: <20041024160814.GT17038@holomorphy.com>
References: <Pine.LNX.4.44.0410241644000.12023-100000@localhost.localdomain>
	<Pine.LNX.4.44.0410241647080.12023-100000@localhost.localdomain>
	<20041024160814.GT17038@holomorphy.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>
> On Sun, Oct 24, 2004 at 04:49:48PM +0100, Hugh Dickins wrote:
>  > Signed-off-by: Hugh Dickins <hugh@veritas.com>
> 
>  Signed-off-by: William Irwin <wli@holomorphy.com>

I'll change these three to "Acked-by:".  Unless you actually had a hand in
developing these patches, in which case I'll unchange things.
