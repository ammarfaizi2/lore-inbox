Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266117AbUHHSjW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266117AbUHHSjW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Aug 2004 14:39:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266128AbUHHSjW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Aug 2004 14:39:22 -0400
Received: from fw.osdl.org ([65.172.181.6]:7389 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266117AbUHHSjV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Aug 2004 14:39:21 -0400
Date: Sun, 8 Aug 2004 11:37:32 -0700
From: Andrew Morton <akpm@osdl.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: ak@muc.de, mpm@selenic.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Allow to disable shmem.o
Message-Id: <20040808113732.3416a4ee.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.44.0408081705100.1983-100000@localhost.localdomain>
References: <20040808141908.GA94449@muc.de>
	<Pine.LNX.4.44.0408081705100.1983-100000@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins <hugh@veritas.com> wrote:
>
> But somehow I still prefer Matt's patch, which offers a lot more.

Me too - it's sneaky.

I suspect it's more SMp scalable than shmem.c too?
