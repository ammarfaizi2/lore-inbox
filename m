Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261372AbUK0XOb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261372AbUK0XOb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 18:14:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261378AbUK0XOb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 18:14:31 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:13989
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261372AbUK0XO2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Nov 2004 18:14:28 -0500
Date: Sat, 27 Nov 2004 15:12:42 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Joshua Kwan <joshk@triplehelix.org>
Cc: davem@redhat.com, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH 2.6.9] Fix drivers/video/bw2.c compilation
Message-Id: <20041127151242.05c270a9.davem@davemloft.net>
In-Reply-To: <20041127111346.GA30214@darjeeling.triplehelix.org>
References: <20041127111346.GA30214@darjeeling.triplehelix.org>
X-Mailer: Sylpheed version 0.9.99 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Nov 2004 03:13:46 -0800
Joshua Kwan <joshk@triplehelix.org> wrote:

> Here's a patch that allows bw2.c to compile on 2.6.9, just redeclares a
> char* that suddenly went missing. Please apply.
> 
> Signed-off-by: Joshua Kwan <joshk@triplehelix.org>

Fixed already in the current 2.6.10 sources, but thanks.
