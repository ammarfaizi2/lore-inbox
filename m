Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262046AbUL1DLU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262046AbUL1DLU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 22:11:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262036AbUL1DLL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 22:11:11 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:23462
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S262051AbUL1DKg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 22:10:36 -0500
Date: Mon, 27 Dec 2004 19:05:50 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Adrian Bunk <bunk@stusta.de>
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] net/key/af_key.c: make pfkey_table static
Message-Id: <20041227190550.165862d0.davem@davemloft.net>
In-Reply-To: <20041215004254.GG23151@stusta.de>
References: <20041215004254.GG23151@stusta.de>
X-Mailer: Sylpheed version 1.0.0rc (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Dec 2004 01:42:54 +0100
Adrian Bunk <bunk@stusta.de> wrote:

> The patch below makes the needlessly global pfkey_table static.

Applied, thanks Adrian.
