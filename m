Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263714AbUFSWv6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263714AbUFSWv6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 18:51:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264750AbUFSWv6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 18:51:58 -0400
Received: from mx1.redhat.com ([66.187.233.31]:45499 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263714AbUFSWva (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 18:51:30 -0400
Date: Sat, 19 Jun 2004 15:50:08 -0700
From: "David S. Miller" <davem@redhat.com>
To: Andi Kleen <ak@muc.de>
Cc: andrea@suse.de, linux-kernel@vger.kernel.org
Subject: Re: mincore on anon mappings
Message-Id: <20040619155008.5c346688.davem@redhat.com>
In-Reply-To: <m33c4rrt4w.fsf@averell.firstfloor.org>
References: <28R2T-8ld-13@gated-at.bofh.it>
	<28Tev-1Bm-23@gated-at.bofh.it>
	<m33c4rrt4w.fsf@averell.firstfloor.org>
X-Mailer: Sylpheed version 0.9.11 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Jun 2004 02:05:19 +0200
Andi Kleen <ak@muc.de> wrote:

> How about calling it MAP_STRICT or just MAP_CHECK ? 

MAP_STRICT sounds fine to me.
