Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262152AbULQTxc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262152AbULQTxc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 14:53:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262148AbULQTxc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 14:53:32 -0500
Received: from fw.osdl.org ([65.172.181.6]:60830 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262146AbULQTws (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 14:52:48 -0500
Date: Fri, 17 Dec 2004 11:52:25 -0800
From: Andrew Morton <akpm@osdl.org>
To: Werner Almesberger <werner@almesberger.net>
Cc: linux-kernel@vger.kernel.org, vrajesh@umich.edu
Subject: Re: [PATCH 0/3] prio_tree generalization
Message-Id: <20041217115225.4b3aef9c.akpm@osdl.org>
In-Reply-To: <20041217153602.D31842@almesberger.net>
References: <20041217153602.D31842@almesberger.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Werner Almesberger <werner@almesberger.net> wrote:
>
> This patch set for 2.6.10-rc3-bk10 (*) generalizes the prio_tree
>  code such that other subsystems than just VMA can use it.
> 
>  (*) I'm not sure which tree is the most useful base for this.
>      Should I use 2.6.10-rc3-mm* instead of -bk* ? (Or is it
>      already too late for 2.6.10 anyway ?)

Yes, 2.6.10 is in locked-down-try-to-get-the-bugs-out mode.  I'll queue
these up for post-2.6.10.
