Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262029AbUL1C6g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262029AbUL1C6g (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 21:58:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262031AbUL1C6g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 21:58:36 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:62373
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S262029AbUL1C5j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 21:57:39 -0500
Date: Mon, 27 Dec 2004 18:52:56 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Adrian Bunk <bunk@stusta.de>
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] net/socket.c: make a function static
Message-Id: <20041227185256.74f617f4.davem@davemloft.net>
In-Reply-To: <20041212211506.GY22324@stusta.de>
References: <20041212211506.GY22324@stusta.de>
X-Mailer: Sylpheed version 1.0.0rc (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Dec 2004 22:15:06 +0100
Adrian Bunk <bunk@stusta.de> wrote:

> The patch below makes a needlessly global function static.

Applied, I think we used to use this for the compat layers.

Thanks Adrian.
