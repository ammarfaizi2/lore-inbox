Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262037AbUL1DHA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262037AbUL1DHA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 22:07:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262034AbUL1DGX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 22:06:23 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:7590
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S262027AbUL1DEW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 22:04:22 -0500
Date: Mon, 27 Dec 2004 18:59:55 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Adrian Bunk <bunk@stusta.de>
Cc: eis@baty.hanse.de, linux-x25@vger.kernel.org, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] net/x25/: some cleanups
Message-Id: <20041227185955.132a8693.davem@davemloft.net>
In-Reply-To: <20041212212318.GB22324@stusta.de>
References: <20041212212318.GB22324@stusta.de>
X-Mailer: Sylpheed version 1.0.0rc (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Dec 2004 22:23:18 +0100
Adrian Bunk <bunk@stusta.de> wrote:

> The patch below includes the following cleanups:
> - make some needlessly global code static
> - remove the following unused global functions:
>   - net/x25/x25_dev.c: x25_llc_receive_frame
>   - net/x25/x25_link.c: x25_transmit_diagnostic

Applied, thanks Adrian.
