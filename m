Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263355AbTHXLtj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Aug 2003 07:49:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263417AbTHXLtj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Aug 2003 07:49:39 -0400
Received: from pizda.ninka.net ([216.101.162.242]:52416 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S263355AbTHXLti (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Aug 2003 07:49:38 -0400
Date: Sun, 24 Aug 2003 04:41:50 -0700
From: "David S. Miller" <davem@redhat.com>
To: Vinay K Nallamothu <vinay-rc@naturesoft.net>
Cc: vinay-rc@naturesoft.net, netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.0-test4][NET] sk_mca.c: fix linker error
Message-Id: <20030824044150.6b396fdc.davem@redhat.com>
In-Reply-To: <1061646315.1141.26.camel@lima.royalchallenge.com>
References: <1061644938.2787.22.camel@lima.royalchallenge.com>
	<1061646315.1141.26.camel@lima.royalchallenge.com>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 Aug 2003 19:15:15 +0530
Vinay K Nallamothu <vinay-rc@naturesoft.net> wrote:

> On Sat, 2003-08-23 at 18:52, Vinay K Nallamothu wrote:
> > Hi,
> > 
> > This patch fixes the following linker error due to a typo:
> > 
> > *** Warning: "spin_lock_irqrestore" [drivers/net/sk_mca.ko] undefined!
> Oops. missed out few more. Here is the updated patch.

Aplied, thanks.
