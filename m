Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261209AbUL1S2u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261209AbUL1S2u (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Dec 2004 13:28:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261221AbUL1S2u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Dec 2004 13:28:50 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:65454
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261209AbUL1S2q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Dec 2004 13:28:46 -0500
Date: Tue, 28 Dec 2004 10:27:21 -0800
From: "David S. Miller" <davem@davemloft.net>
To: John Way <wayjd@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Sym-2
Message-Id: <20041228102721.55f8e1ad.davem@davemloft.net>
In-Reply-To: <20041228172554.38787.qmail@web60307.mail.yahoo.com>
References: <20041228172554.38787.qmail@web60307.mail.yahoo.com>
X-Mailer: Sylpheed version 1.0.0rc (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Dec 2004 09:25:54 -0800 (PST)
John Way <wayjd@yahoo.com> wrote:

> 1. New SYM-2 mess. MKINITRD complains.

Tell mkinitrd to look for "sym53c8xx_2" instead of plain
"sym53c8xx".
