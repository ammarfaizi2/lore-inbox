Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261269AbVCWVKJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261269AbVCWVKJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 16:10:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262918AbVCWVI7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 16:08:59 -0500
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:17552
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261338AbVCWVEr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 16:04:47 -0500
Date: Wed, 23 Mar 2005 13:01:30 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: bunk@stusta.de, linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/net/eql.c: kill dead code
Message-Id: <20050323130130.5aaf0d83.davem@davemloft.net>
In-Reply-To: <20050323202823.GA11453@havoc.gtf.org>
References: <20050322215354.GM1948@stusta.de>
	<20050323122212.776975d4.davem@davemloft.net>
	<20050323202823.GA11453@havoc.gtf.org>
X-Mailer: Sylpheed version 1.0.3 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Mar 2005 15:28:23 -0500
Jeff Garzik <jgarzik@pobox.com> wrote:

> Note that I apply drivers/net/* stuff too, including this one...  :)

I realized this was a possibility, BK will figure it out once
it gets merged so no worries.

Generally, besides bonding, I pretty much take the changes in
for non-hardware drivers like eql, shaper, and friends.
