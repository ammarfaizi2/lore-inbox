Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262081AbUL1FZH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262081AbUL1FZH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Dec 2004 00:25:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262072AbUL1FW6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Dec 2004 00:22:58 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:41385
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S262077AbUL1FWs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Dec 2004 00:22:48 -0500
Date: Mon, 27 Dec 2004 21:21:30 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: Re: [PATCH 25/30] return statement cleanup - kill pointless
 parentheses in net/irda/irnet/irnet.h
Message-Id: <20041227212130.2ee61957.davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.61.0412160138330.3864@dragon.hygekrogen.localhost>
References: <Pine.LNX.4.61.0412160138330.3864@dragon.hygekrogen.localhost>
X-Mailer: Sylpheed version 1.0.0rc (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Dec 2004 01:39:29 +0100 (CET)
Jesper Juhl <juhl-lkml@dif.dk> wrote:

> 
> This patch removes pointless parentheses from return statements in 
> net/irda/irnet/irnet.h

Applied, thanks Jesper.
