Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261454AbULIEpU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261454AbULIEpU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 23:45:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261455AbULIEpU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 23:45:20 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:49853
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261454AbULIEpS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 23:45:18 -0500
Date: Wed, 8 Dec 2004 20:42:59 -0800
From: "David S. Miller" <davem@davemloft.net>
To: felix-linuxkernel@fefe.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: ipv6 getting more and more broken
Message-Id: <20041208204259.5eee3397.davem@davemloft.net>
In-Reply-To: <20041209024649.GA26553@codeblau.de>
References: <20041209024649.GA26553@codeblau.de>
X-Mailer: Sylpheed version 1.0.0beta3 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Dec 2004 03:46:49 +0100
felix-linuxkernel@fefe.de wrote:

> In 2.6.9, the machines don't even get a link-local address when bringing
> an interface up!

This is fixed in current 2.6.10-rcX kernels.
