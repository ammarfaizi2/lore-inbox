Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262035AbUL1C7m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262035AbUL1C7m (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 21:59:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262031AbUL1C6r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 21:58:47 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:60581
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S262027AbUL1C4d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 21:56:33 -0500
Date: Mon, 27 Dec 2004 18:51:51 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Adrian Bunk <bunk@stusta.de>
Cc: ralf@linux-mips.org, linux-hams@vger.kernel.org, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] /net/ax25/: some cleanups
Message-Id: <20041227185151.2a7ceb71.davem@davemloft.net>
In-Reply-To: <20041212211339.GX22324@stusta.de>
References: <20041212211339.GX22324@stusta.de>
X-Mailer: Sylpheed version 1.0.0rc (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Dec 2004 22:13:39 +0100
Adrian Bunk <bunk@stusta.de> wrote:

> The patch below contains the following cleanups:
> - make two needlessly global functions static
> - net/ax25/ax25_addr.c: remove the unused global function ax25digicmp

Applied, thanks Adrian.
