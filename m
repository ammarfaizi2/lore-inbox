Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271572AbTGQVlp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 17:41:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271585AbTGQVlp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 17:41:45 -0400
Received: from pizda.ninka.net ([216.101.162.242]:44262 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S271572AbTGQViS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 17:38:18 -0400
Date: Thu, 17 Jul 2003 14:43:26 -0700
From: "David S. Miller" <davem@redhat.com>
To: Harald Welte <laforge@netfilter.org>
Cc: netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix ip_nat_ftp in 2.6.0-test1
Message-Id: <20030717144326.4f496995.davem@redhat.com>
In-Reply-To: <20030717211254.GA27685@sunbeam.de.gnumonks.org>
References: <20030717211254.GA27685@sunbeam.de.gnumonks.org>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jul 2003 23:12:54 +0200
Harald Welte <laforge@netfilter.org> wrote:

> This is a 2.6 only fix for the FTP NAT helper code.  The patch below
> (by Martin Josefsson) also closes Bug 933 in the kernel bug tracker.
> 
> The bug was introduced while making the helper compliant to the recently
> introduced support for nonlinear skb's in netfilter.

Applied, thanks Harald.
