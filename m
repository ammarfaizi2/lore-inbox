Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262074AbUL1FWt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262074AbUL1FWt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Dec 2004 00:22:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262075AbUL1FVc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Dec 2004 00:21:32 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:36521
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S262072AbUL1FUY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Dec 2004 00:20:24 -0500
Date: Mon, 27 Dec 2004 21:15:48 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Adrian Bunk <bunk@stusta.de>
Cc: ralf@linux-mips.org, linux-hams@vger.kernel.org, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] net/netrom/: make some code static
Message-Id: <20041227211548.3d511579.davem@davemloft.net>
In-Reply-To: <20041215012107.GE12937@stusta.de>
References: <20041215012107.GE12937@stusta.de>
X-Mailer: Sylpheed version 1.0.0rc (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Dec 2004 02:21:07 +0100
Adrian Bunk <bunk@stusta.de> wrote:

> The patch below makes some needlessly global code static.

Applied, thanks Adrian.
