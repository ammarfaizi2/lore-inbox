Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262902AbVCWU2Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262902AbVCWU2Y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 15:28:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262908AbVCWU2H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 15:28:07 -0500
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:25297
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S262902AbVCWUZe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 15:25:34 -0500
Date: Wed, 23 Mar 2005 12:22:12 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Adrian Bunk <bunk@stusta.de>
Cc: jgarzik@pobox.com, linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/net/eql.c: kill dead code
Message-Id: <20050323122212.776975d4.davem@davemloft.net>
In-Reply-To: <20050322215354.GM1948@stusta.de>
References: <20050322215354.GM1948@stusta.de>
X-Mailer: Sylpheed version 1.0.3 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Mar 2005 22:53:54 +0100
Adrian Bunk <bunk@stusta.de> wrote:

> This patch removes some obviously dead code found by the Coverity 
> checker.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Applied, thanks Adrian.
