Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262036AbUL1DLV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262036AbUL1DLV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 22:11:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262042AbUL1DK6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 22:10:58 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:19110
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S262045AbUL1DIg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 22:08:36 -0500
Date: Mon, 27 Dec 2004 19:03:53 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Adrian Bunk <bunk@stusta.de>
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] net/ethernet/eth.c: make a function static
Message-Id: <20041227190353.69099ddf.davem@davemloft.net>
In-Reply-To: <20041214134842.GD23151@stusta.de>
References: <20041214134842.GD23151@stusta.de>
X-Mailer: Sylpheed version 1.0.0rc (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Dec 2004 14:48:42 +0100
Adrian Bunk <bunk@stusta.de> wrote:

> The patch below makes a needlessly global function static.

Applied, thanks Adrian.
