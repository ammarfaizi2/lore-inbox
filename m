Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266246AbUBDCCZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 21:02:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266247AbUBDCCZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 21:02:25 -0500
Received: from fw.osdl.org ([65.172.181.6]:32721 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266246AbUBDCCY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 21:02:24 -0500
Date: Tue, 3 Feb 2004 18:03:52 -0800
From: Andrew Morton <akpm@osdl.org>
To: James Simmons <jsimmons@infradead.org>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       linux-fbdev-devel@lists.sourceforge.net,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: fb.h header fix.
Message-Id: <20040203180352.364da230.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.44.0402040109570.11656-100000@phoenix.infradead.org>
References: <Pine.LNX.4.44.0402040109570.11656-100000@phoenix.infradead.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Simmons <jsimmons@infradead.org> wrote:
>
> The XFree86 fbdev server build breaks with the current fb.h. This patch 
>  fixes that.

The previous version of this patch caused the ppc64 build to fail.  Did
that get addressed?
