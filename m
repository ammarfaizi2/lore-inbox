Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262025AbUL1CvJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262025AbUL1CvJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 21:51:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262026AbUL1CvJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 21:51:09 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:51621
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S262025AbUL1CvB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 21:51:01 -0500
Date: Mon, 27 Dec 2004 18:46:17 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Adrian Bunk <bunk@stusta.de>
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] remove unused
Message-Id: <20041227184617.4444fae4.davem@davemloft.net>
In-Reply-To: <20041212195047.GH22324@stusta.de>
References: <20041212195047.GH22324@stusta.de>
X-Mailer: Sylpheed version 1.0.0rc (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Dec 2004 20:50:47 +0100
Adrian Bunk <bunk@stusta.de> wrote:

> I wasn't able to find any usage of this file (it seems the 
> EXPORT_SYMBOL's were moved away, but deleting the filw was forgotten).

Applied, thanks.
