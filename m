Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266507AbUA3A4x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 19:56:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266512AbUA3A4x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 19:56:53 -0500
Received: from mx1.redhat.com ([66.187.233.31]:48316 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266507AbUA3A4w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 19:56:52 -0500
Date: Thu, 29 Jan 2004 16:56:45 -0800
From: "David S. Miller" <davem@redhat.com>
To: Andi Kleen <ak@suse.de>
Cc: yoshfuji@linux-ipv6.org, kas@informatics.muni.cz,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: Patch: IPv6/AMD64: bug in net/ipv6/ndisc.c
Message-Id: <20040129165645.4dde4ffc.davem@redhat.com>
In-Reply-To: <20040130014031.31ec050f.ak@suse.de>
References: <20040129221538.J24747@fi.muni.cz>
	<20040130.083743.20740540.yoshfuji@linux-ipv6.org>
	<20040129153953.3dd2cd23.davem@redhat.com>
	<20040130014031.31ec050f.ak@suse.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Jan 2004 01:40:31 +0100
Andi Kleen <ak@suse.de> wrote:

> Fine by me. I've been ignoring it forever. But don't you see it on sparc64 too?

Nope, for some reason gcc-3.2.3 on my systems is missing it.
Otherwise I would have killed this earlier :)
