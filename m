Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268180AbUHXSkF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268180AbUHXSkF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 14:40:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268193AbUHXSkF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 14:40:05 -0400
Received: from mx1.redhat.com ([66.187.233.31]:9907 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268180AbUHXSkC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 14:40:02 -0400
Date: Tue, 24 Aug 2004 11:39:23 -0700
From: "David S. Miller" <davem@redhat.com>
To: Felipe Alfaro Solana <lkml@felipe-alfaro.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.9-rc1 compile fix in ipv4/ip_conntrack_proto_udp
Message-Id: <20040824113923.43507152.davem@redhat.com>
In-Reply-To: <200408241226.30298.lkml@felipe-alfaro.com>
References: <200408241226.30298.lkml@felipe-alfaro.com>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


All of your netfilter_ipv4.h include patches applied,
thanks Felipe.
