Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262077AbUL1F0g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262077AbUL1F0g (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Dec 2004 00:26:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262079AbUL1F0A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Dec 2004 00:26:00 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:43689
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S262077AbUL1FXz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Dec 2004 00:23:55 -0500
Date: Mon, 27 Dec 2004 21:19:11 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Adrian Bunk <bunk@stusta.de>
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] net/sched/: possible cleanups
Message-Id: <20041227211911.66c0b643.davem@davemloft.net>
In-Reply-To: <20041215012754.GH12937@stusta.de>
References: <20041215012754.GH12937@stusta.de>
X-Mailer: Sylpheed version 1.0.0rc (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Dec 2004 02:27:54 +0100
Adrian Bunk <bunk@stusta.de> wrote:

> The patch below contans the following possible cleanups:
> - make some needlessly global code static
> - sch_htb.c: #undef HTB_DEBUG

Applied, thanks Adrian.
