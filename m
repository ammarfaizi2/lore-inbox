Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261255AbUKNHmi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261255AbUKNHmi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 02:42:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261256AbUKNHmi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 02:42:38 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:56269
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261255AbUKNHmh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 02:42:37 -0500
Date: Sat, 13 Nov 2004 23:25:14 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Adrian Bunk <bunk@stusta.de>
Cc: marcelo.tosatti@cyclades.com, laforge@gnumonks.org,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       patrick@tykepenguin.com, linux-decnet-user@lists.sourceforge.net
Subject: Re: [patch] 2.4.28-rc3: neigh_for_each must be EXPORT_SYMBOL'ed
Message-Id: <20041113232514.61bf760e.davem@davemloft.net>
In-Reply-To: <20041113200735.GD2249@stusta.de>
References: <20041112180052.GE23215@logos.cnet>
	<20041113200735.GD2249@stusta.de>
X-Mailer: Sylpheed version 0.9.99 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Nov 2004 21:07:35 +0100
Adrian Bunk <bunk@stusta.de> wrote:

> neigh_for_each must be EXPORT_SYMBOL'ed (as it is in 2.6):

Good catch Adrian, I'll apply this and push it to
Marcelo.

Thanks.
