Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262110AbVDAGfg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262110AbVDAGfg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 01:35:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262317AbVDAGfg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 01:35:36 -0500
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:28560
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S262110AbVDAGf2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 01:35:28 -0500
Date: Thu, 31 Mar 2005 22:31:10 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Adrian Bunk <bunk@stusta.de>
Cc: kai.germaschewski@gmx.de, kkeil@suse.de, isdn4linux@listserv.isdn4linux.de,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/isdn/i4l/isdn_ppp.c: fix off by one errors
Message-Id: <20050331223110.6b4b16e8.davem@davemloft.net>
In-Reply-To: <20050325183215.GE3153@stusta.de>
References: <20050325183215.GE3153@stusta.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Mar 2005 19:32:15 +0100
Adrian Bunk <bunk@stusta.de> wrote:

> This patch fixes several off by one errors found by the Coverity checker
> (ippp_table has ISDN_MAX_CHANNELS elements).
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Applied, thanks Adrian.
