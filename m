Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275064AbTHQHjJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 03:39:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275066AbTHQHjJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 03:39:09 -0400
Received: from fw.osdl.org ([65.172.181.6]:45184 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S275064AbTHQHjI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 03:39:08 -0400
Date: Sun, 17 Aug 2003 00:40:13 -0700
From: Andrew Morton <akpm@osdl.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] O16.2int
Message-Id: <20030817004013.14c399da.akpm@osdl.org>
In-Reply-To: <200308161902.52337.kernel@kolivas.org>
References: <200308161902.52337.kernel@kolivas.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas <kernel@kolivas.org> wrote:
>
> Much simpler

But broken.

The machine runs about 100x slower than normal.  The screensaver cut in
halfway through the initscripts ;) That's on 2-way.  The same kernel works
OK on uniprocessor.

