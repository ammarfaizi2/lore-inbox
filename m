Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262031AbUL1DLj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262031AbUL1DLj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 22:11:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262042AbUL1DL2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 22:11:28 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:16806
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S262031AbUL1DHa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 22:07:30 -0500
Date: Mon, 27 Dec 2004 19:02:49 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Adrian Bunk <bunk@stusta.de>
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] net/core/: misc possible cleanups
Message-Id: <20041227190249.6afda3df.davem@davemloft.net>
In-Reply-To: <20041214045758.GA23151@stusta.de>
References: <20041214045758.GA23151@stusta.de>
X-Mailer: Sylpheed version 1.0.0rc (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Dec 2004 05:57:58 +0100
Adrian Bunk <bunk@stusta.de> wrote:

>   - skbuff.c: skb_insert
>   - skbuff.c: skb_iter_first
>   - skbuff.c: skb_iter_next
>   - skbuff.c: skb_iter_abort

These are actually planned to be used, let's keep them in for
now.
