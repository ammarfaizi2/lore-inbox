Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262049AbUL1D1K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262049AbUL1D1K (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 22:27:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262052AbUL1DX1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 22:23:27 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:42150
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S262049AbUL1DV4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 22:21:56 -0500
Date: Mon, 27 Dec 2004 19:16:50 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Adrian Bunk <bunk@stusta.de>
Cc: wensong@linux-vs.org, ja@ssi.bg, lvs-users@linuxvirtualserver.org,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] net/ipvs/: make some code static
Message-Id: <20041227191650.1bedf2a8.davem@davemloft.net>
In-Reply-To: <20041215005801.GB11972@stusta.de>
References: <20041215005801.GB11972@stusta.de>
X-Mailer: Sylpheed version 1.0.0rc (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Dec 2004 01:58:01 +0100
Adrian Bunk <bunk@stusta.de> wrote:

> The patch below makes some needlessly global code static.

Applied, thanks Adrian.
