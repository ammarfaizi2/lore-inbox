Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267417AbUIFDrk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267417AbUIFDrk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 23:47:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267427AbUIFDrk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 23:47:40 -0400
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:48562
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S267417AbUIFDrj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 23:47:39 -0400
Date: Sun, 5 Sep 2004 20:45:30 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Dave Airlie <airlied@linux.ie>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] DRM remove DMA/IRQ macros..
Message-Id: <20040905204530.491dc4f1.davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.58.0409060440320.22266@skynet>
References: <Pine.LNX.4.58.0409051015570.14009@skynet>
	<20040905203622.32f75496.davem@davemloft.net>
	<Pine.LNX.4.58.0409060440320.22266@skynet>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Sep 2004 04:42:11 +0100 (IST)
Dave Airlie <airlied@linux.ie> wrote:

> Thanks Dave, I'll look into it, I've no way to build or test the ffb (I'm
> not even sure the user space code works anymore), so I rely on feedback
> for it from others..

Ask Andrew Morton for pointers to handy sparc64 cross
compilers, which he uses himself to sanitize the -mm
patch set builds.  Then you can sanity check the ffb
driver build too.
