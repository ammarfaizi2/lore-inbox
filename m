Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271045AbTHQVGK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 17:06:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271051AbTHQVGK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 17:06:10 -0400
Received: from fw.osdl.org ([65.172.181.6]:56459 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S271045AbTHQVGI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 17:06:08 -0400
Date: Sun, 17 Aug 2003 14:06:48 -0700
From: Andrew Morton <akpm@osdl.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] O16.2int
Message-Id: <20030817140648.5ad9b075.akpm@osdl.org>
In-Reply-To: <200308180059.07813.kernel@kolivas.org>
References: <200308161902.52337.kernel@kolivas.org>
	<20030817004013.14c399da.akpm@osdl.org>
	<200308180059.07813.kernel@kolivas.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas <kernel@kolivas.org> wrote:
>
> Reverting the !in_interrupt nonsense should be enough to avoid the dreaded 
>  screensaver at boottime I hope. Does this fix it?

yes, that's a fix.
