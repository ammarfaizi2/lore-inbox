Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262197AbVCJEvK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262197AbVCJEvK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 23:51:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261924AbVCJEtj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 23:49:39 -0500
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:43719
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S262383AbVCJEs4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 23:48:56 -0500
Date: Wed, 9 Mar 2005 20:44:48 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Adrian Bunk <bunk@stusta.de>
Cc: jgarzik@pobox.com, linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/net/sunhme.c: make a struct static
Message-Id: <20050309204448.60ab1bda.davem@davemloft.net>
In-Reply-To: <20050219083618.GO4337@stusta.de>
References: <20050219083618.GO4337@stusta.de>
X-Mailer: Sylpheed version 1.0.1 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Feb 2005 09:36:18 +0100
Adrian Bunk <bunk@stusta.de> wrote:

> This patch makes a needlessly global struct static.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Applied, thanks Adrian.
