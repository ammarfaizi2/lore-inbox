Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272359AbTGYWJz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 18:09:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272366AbTGYWJz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 18:09:55 -0400
Received: from pizda.ninka.net ([216.101.162.242]:24485 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S272359AbTGYWJy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 18:09:54 -0400
Date: Fri, 25 Jul 2003 15:22:21 -0700
From: "David S. Miller" <davem@redhat.com>
To: Harald Welte <laforge@netfilter.org>
Cc: netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org
Subject: Re: Update: [PATCH 2.6] iptables MIRROR target fixes
Message-Id: <20030725152221.1b751bd0.davem@redhat.com>
In-Reply-To: <20030725205242.GH3244@sunbeam.de.gnumonks.org>
References: <20030719142648.GS32475@sunbeam.de.gnumonks.org>
	<20030725205242.GH3244@sunbeam.de.gnumonks.org>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Jul 2003 22:52:42 +0200
Harald Welte <laforge@netfilter.org> wrote:

> On Sat, Jul 19, 2003 at 04:26:48PM +0200, Harald Welte wrote:
> 
> > This is the first of my 2.6 merge of the recent bugfixes (all tested
> > against 2.6.0-test1).  You might need to apply them incrementally
> > (didn't test it in a different order).
> 
> Unfortunately I introduced a typo during the merge (which in turn
> introduced a new bug).
> 
> Please incrementially apply the following patch, thanks.

All 2.6.x netfilter patches applied, thanks.
