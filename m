Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262028AbUL1Czj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262028AbUL1Czj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 21:55:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262027AbUL1Czi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 21:55:38 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:59045
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S262028AbUL1Czb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 21:55:31 -0500
Date: Mon, 27 Dec 2004 18:50:48 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Adrian Bunk <bunk@stusta.de>
Cc: acme@conectiva.com.br, netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] net/appletalk/: make some code static
Message-Id: <20041227185048.031f4924.davem@davemloft.net>
In-Reply-To: <20041212211128.GW22324@stusta.de>
References: <20041212211128.GW22324@stusta.de>
X-Mailer: Sylpheed version 1.0.0rc (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Dec 2004 22:11:28 +0100
Adrian Bunk <bunk@stusta.de> wrote:

> The patch below makes some needlessly global code static.

Looks good, applied.  Thanks Adrian.
