Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262152AbTKMF06 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 00:26:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262198AbTKMF06
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 00:26:58 -0500
Received: from pizda.ninka.net ([216.101.162.242]:23183 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262152AbTKMF05 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 00:26:57 -0500
Date: Wed, 12 Nov 2003 21:20:25 -0800
From: "David S. Miller" <davem@redhat.com>
To: "Beau E. Cox" <beau@beaucox.com>
Cc: linux-kernel@vger.kernel.org, netfilter-devel@lists.netfilter.org
Subject: Re: PROBLEM: 2.4.23-rc4 -> rc1 hang with change to ip_nat_core.c
 made in pre4
Message-Id: <20031112212025.5eb29f52.davem@redhat.com>
In-Reply-To: <200311121924.38376.beau@beaucox.com>
References: <200311121442.27406.beau@beaucox.com>
	<20031112195908.0611fe2e.davem@redhat.com>
	<200311121924.38376.beau@beaucox.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Nov 2003 19:24:38 -1000
"Beau E. Cox" <beau@beaucox.com> wrote:

> On Wednesday 12 November 2003 05:59 pm, David S. Miller wrote:
> > Marcelo has reverted the change in question, so his current
> > 2.4.x tree should be fine.
> 
> Thank you so much.
> 
> I guess this makes me an honary Linux kernel contribitor, er...
> uncontributor... :)

I take what I said back temporarily, Marcelo didn't revert the
change yet but I have just reminded him to do so.

It should be fixed by the time 2.4.23 final rolls out.
