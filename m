Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263903AbUBLEYB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 23:24:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266267AbUBLEYB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 23:24:01 -0500
Received: from mx1.redhat.com ([66.187.233.31]:50826 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263903AbUBLEX7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 23:23:59 -0500
Date: Wed, 11 Feb 2004 20:23:54 -0800
From: "David S. Miller" <davem@redhat.com>
To: Jan Kasprzak <kas@informatics.muni.cz>
Cc: yoshfuji@linux-ipv6.org, linux-kernel@vger.kernel.org,
       kuznet@ms2.inr.ac.ru
Subject: Re: [Patch] Netlink BUG() on AMD64
Message-Id: <20040211202354.4411c978.davem@redhat.com>
In-Reply-To: <20040212051009.A16112@fi.muni.cz>
References: <20040205183604.N26559@fi.muni.cz>
	<20040211181113.GA2849@fi.muni.cz>
	<20040212.034537.11291491.yoshfuji@linux-ipv6.org>
	<20040212.035825.101259632.yoshfuji@linux-ipv6.org>
	<20040211194909.0ab130cc.davem@redhat.com>
	<20040212051009.A16112@fi.muni.cz>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Feb 2004 05:10:10 +0100
Jan Kasprzak <kas@informatics.muni.cz> wrote:

> However, the same problem is in 2.4, so please push these fixes to
> Marcelo as well.

I know, I made the change in both trees.

But thanks for reminding me.
