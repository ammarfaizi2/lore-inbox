Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263018AbTJUIYR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 04:24:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263019AbTJUIYR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 04:24:17 -0400
Received: from rth.ninka.net ([216.101.162.244]:56461 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S263018AbTJUIYQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 04:24:16 -0400
Date: Tue, 21 Oct 2003 01:24:11 -0700
From: "David S. Miller" <davem@redhat.com>
To: Clemens Schwaighofer <gullevek@gullevek.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test8 csv from today
Message-Id: <20031021012411.3f2840a6.davem@redhat.com>
In-Reply-To: <200310211533.44313.gullevek@gullevek.org>
References: <200310211533.44313.gullevek@gullevek.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Oct 2003 15:33:44 +0900
Clemens Schwaighofer <gullevek@gullevek.org> wrote:

> net/built-in.o(.text+0x67d43): In function `ipip6_rcv':
> : undefined reference to `__secpath_destroy'
> make: *** [.tmp_vmlinux1] Error 1

It's not fixed in Linus's tree yet, he will pull in the fix
over the next day or two.
