Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262039AbUL1D10@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262039AbUL1D10 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 22:27:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262043AbUL1D1W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 22:27:22 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:46758
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S262039AbUL1D0k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 22:26:40 -0500
Date: Mon, 27 Dec 2004 19:21:51 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Adrian Bunk <bunk@stusta.de>
Cc: acme@conectiva.com.br, linux-net@vger.kernel.or, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] net/ipx/: make some code static
Message-Id: <20041227192151.77b5db4d.davem@davemloft.net>
In-Reply-To: <20041215005925.GC11972@stusta.de>
References: <20041215005925.GC11972@stusta.de>
X-Mailer: Sylpheed version 1.0.0rc (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Dec 2004 01:59:25 +0100
Adrian Bunk <bunk@stusta.de> wrote:

> The patch below makes some needlessly global code static.

Applied, thanks Adrian.
