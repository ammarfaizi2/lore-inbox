Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261594AbVDSS7L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261594AbVDSS7L (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 14:59:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261605AbVDSS7K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 14:59:10 -0400
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:24283
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261594AbVDSS7I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 14:59:08 -0400
Date: Tue, 19 Apr 2005 11:52:55 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Martin Hicks <mort@wildopensource.com>
Cc: akpm@osdl.org, holt@sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pgtables: fix GFP_KERNEL allocation with preempt
 disabled
Message-Id: <20050419115255.2d35840e.davem@davemloft.net>
In-Reply-To: <20050419184758.GI21616@localhost>
References: <20050419170413.GB21616@localhost>
	<20050419113044.26911ebf.davem@davemloft.net>
	<20050419184758.GI21616@localhost>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Apr 2005 14:47:58 -0400
Martin Hicks <mort@wildopensource.com> wrote:

> Okay, here's an updated patch.

Looks great.
