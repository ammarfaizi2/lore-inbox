Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261678AbUDNUZd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 16:25:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261654AbUDNUXP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 16:23:15 -0400
Received: from mx1.redhat.com ([66.187.233.31]:28556 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261678AbUDNUWj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 16:22:39 -0400
Date: Wed, 14 Apr 2004 13:22:18 -0700
From: "David S. Miller" <davem@redhat.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: Compile problem with sparc64
Message-Id: <20040414132218.56106471.davem@redhat.com>
In-Reply-To: <1081973754.3372.5.camel@pegasus>
References: <1081973754.3372.5.camel@pegasus>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We know, see other postings from today.

Just comment out the "-Werror" line in arch/sparc64/kernel/Makefile
for a quick fix.
