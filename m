Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262038AbUL1DKl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262038AbUL1DKl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 22:10:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262034AbUL1DHQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 22:07:16 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:14502
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S262031AbUL1DGV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 22:06:21 -0500
Date: Mon, 27 Dec 2004 19:01:33 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Adrian Bunk <bunk@stusta.de>
Cc: jmorris@intercode.com.au, netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] net/xfrm/: some cleanups
Message-Id: <20041227190133.0fdfe915.davem@davemloft.net>
In-Reply-To: <20041212212523.GC22324@stusta.de>
References: <20041212212523.GC22324@stusta.de>
X-Mailer: Sylpheed version 1.0.0rc (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Dec 2004 22:25:23 +0100
Adrian Bunk <bunk@stusta.de> wrote:

> The patch below contains the following changes:
> - make some needlessly global code static
> - remove the EXPORT_SYMBOL_GPL'ed but unused function 
>   xfrm_calg_get_byidx

Looks fine, applied.

Thanks Adrian.
