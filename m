Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266175AbUHMQFg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266175AbUHMQFg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 12:05:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266124AbUHMQFf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 12:05:35 -0400
Received: from mx1.redhat.com ([66.187.233.31]:1189 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266147AbUHMQFZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 12:05:25 -0400
Date: Fri, 13 Aug 2004 09:03:09 -0700
From: "David S. Miller" <davem@redhat.com>
To: Admar Schoonen <admar@luon.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc4 on sparc64 oopses at boot and no working XFree86
Message-Id: <20040813090309.49695236.davem@redhat.com>
In-Reply-To: <20040813114320.GJ21828@azrael.luon.net>
References: <20040813114320.GJ21828@azrael.luon.net>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Turn off CONFIG_PREEMPT if you want that OOPS message to go
away, it happens to be harmless though.

I have no idea wrt. your xfree86 problems.

Why not post this on the correct list, sparclinux@vger.kernel.org,
btw?

