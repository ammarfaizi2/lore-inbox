Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263995AbUHBXZj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263995AbUHBXZj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 19:25:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264085AbUHBXZj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 19:25:39 -0400
Received: from fw.osdl.org ([65.172.181.6]:6824 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263995AbUHBXZh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 19:25:37 -0400
Date: Mon, 2 Aug 2004 16:28:46 -0700
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] let 4KSTACKS depend on EXPERIMENTAL (fwd)
Message-Id: <20040802162846.3929e463.akpm@osdl.org>
In-Reply-To: <20040802225951.GR2746@fs.tum.de>
References: <20040802225951.GR2746@fs.tum.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@fs.tum.de> wrote:
>
> I'd like to see the patch below included in 2.6.8 .

I'm not seeing many (any) bug reports from this, and I'd generally prefer
to keep people pushing down on the stack utilisation anyway.

So I'm disinclined to reduce 4k stacks' testing coverage...
