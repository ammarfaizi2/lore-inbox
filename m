Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267916AbUHUVFm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267916AbUHUVFm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 17:05:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267870AbUHUVFY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 17:05:24 -0400
Received: from fw.osdl.org ([65.172.181.6]:38541 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267916AbUHUVCN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 17:02:13 -0400
Date: Sat, 21 Aug 2004 14:00:16 -0700
From: Andrew Morton <akpm@osdl.org>
To: John Levon <levon@movementarian.org>
Cc: oprofile-list@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] OProfile ia64 performance counter support
Message-Id: <20040821140016.33900da7.akpm@osdl.org>
In-Reply-To: <20040821195206.GA10240@compsoc.man.ac.uk>
References: <20040821195206.GA10240@compsoc.man.ac.uk>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Levon <levon@movementarian.org> wrote:
>
> This patch provides support for IA64 hardware performance counters via
>  the perfmon interface.

OK - I'll plop this in -mm but I'd ask Tony to do the final merge as and
when it suits the ia64 team.

What's the story on userspace support for oprofile-on-ia64?
