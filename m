Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262848AbVCPXA3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262848AbVCPXA3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 18:00:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262861AbVCPXAT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 18:00:19 -0500
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:11411
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S262843AbVCPW5w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 17:57:52 -0500
Date: Wed, 16 Mar 2005 14:52:36 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Adrian Bunk <bunk@stusta.de>
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] net/ipv6/ndisc.c: make a function static
Message-Id: <20050316145236.2d9bb352.davem@davemloft.net>
In-Reply-To: <20050315144712.GM3189@stusta.de>
References: <20050315144712.GM3189@stusta.de>
X-Mailer: Sylpheed version 1.0.1 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Mar 2005 15:47:13 +0100
Adrian Bunk <bunk@stusta.de> wrote:

> This patch makes a needlessly global function static.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Applied, thanks Adrian.
