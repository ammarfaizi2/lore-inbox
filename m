Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265772AbUHPVYd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265772AbUHPVYd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 17:24:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266341AbUHPVYd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 17:24:33 -0400
Received: from mx1.redhat.com ([66.187.233.31]:11737 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265772AbUHPVYc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 17:24:32 -0400
Date: Mon, 16 Aug 2004 14:22:06 -0700
From: "David S. Miller" <davem@redhat.com>
To: Cal Peake <cp@absolutedigital.net>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] net/ipv4/proc.c
Message-Id: <20040816142206.7d2913af.davem@redhat.com>
In-Reply-To: <Pine.LNX.4.60.0408161505220.29938@linaeum.absolutedigital.net>
References: <Pine.LNX.4.60.0408161505220.29938@linaeum.absolutedigital.net>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Aug 2004 15:20:18 -0400 (EDT)
Cal Peake <cp@absolutedigital.net> wrote:

> Between 2.6.8-rc2-bk1 and 2.6.8-rc2-bk2 net/ipv4/proc.c was updated to use 
> a new mechanism for outputting /proc/net/snmp and /proc/net/netstat. The 
> small patch attached fixes a problem when doing `netstat -s`

Good catch, patch applied thanks Cal.
