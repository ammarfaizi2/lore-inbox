Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261365AbTHSUG2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 16:06:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261274AbTHSUEM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 16:04:12 -0400
Received: from pizda.ninka.net ([216.101.162.242]:19854 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S261341AbTHSUDk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 16:03:40 -0400
Date: Tue, 19 Aug 2003 12:56:39 -0700
From: "David S. Miller" <davem@redhat.com>
To: Andi Kleen <ak@muc.de>
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
       kuznet@ms2.inr.ac.ru
Subject: Re: [2.4 PATCH] bugfix: ARP respond on all devices
Message-Id: <20030819125639.505e5764.davem@redhat.com>
In-Reply-To: <m3ada5s9iu.fsf@averell.firstfloor.org>
References: <mfYi.374.31@gated-at.bofh.it>
	<mkbE.6Rk.35@gated-at.bofh.it>
	<m3ada5s9iu.fsf@averell.firstfloor.org>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Aug 2003 22:00:09 +0200
Andi Kleen <ak@muc.de> wrote:

> I suspect if someone fixed this (implementing feedback from the
> neighbour state engine to the rt cache/FIB code for failover) cleanly
> the network maintainers would consider it favourably.

Indeed, I'd be thrilled to see such patches.
