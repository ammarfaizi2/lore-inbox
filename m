Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261724AbVBIAw3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261724AbVBIAw3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 19:52:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261725AbVBIAw2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 19:52:28 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:27090
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261724AbVBIAw1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 19:52:27 -0500
Date: Tue, 8 Feb 2005 16:48:57 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Adrian Bunk <bunk@stusta.de>
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] kill xfrm_export.c
Message-Id: <20050208164857.1c51656e.davem@davemloft.net>
In-Reply-To: <20050119091715.GQ1841@stusta.de>
References: <20050119091715.GQ1841@stusta.de>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Jan 2005 10:17:15 +0100
Adrian Bunk <bunk@stusta.de> wrote:

> This patch removes xfrm_export.c and moves the EXPORT_SYMBOL{,_GPL}'s to 
> the files where the actual functions are.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Applied, thanks Adrian.
