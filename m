Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262063AbTKMD7a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 22:59:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262119AbTKMD7a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 22:59:30 -0500
Received: from rth.ninka.net ([216.101.162.244]:36236 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S262063AbTKMD73 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 22:59:29 -0500
Date: Wed, 12 Nov 2003 19:59:08 -0800
From: "David S. Miller" <davem@redhat.com>
To: "Beau E. Cox" <beau@beaucox.com>
Cc: linux-kernel@vger.kernel.org, netfilter-devel@lists.netfilter.org
Subject: Re: PROBLEM: 2.4.23-rc4 -> rc1 hang with change to ip_nat_core.c
 made in pre4
Message-Id: <20031112195908.0611fe2e.davem@redhat.com>
In-Reply-To: <200311121442.27406.beau@beaucox.com>
References: <200311121442.27406.beau@beaucox.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Marcelo has reverted the change in question, so his current
2.4.x tree should be fine.
