Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262987AbUB1HwY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Feb 2004 02:52:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262982AbUB1HwY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Feb 2004 02:52:24 -0500
Received: from mx1.redhat.com ([66.187.233.31]:33711 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262987AbUB1Hvv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Feb 2004 02:51:51 -0500
Date: Fri, 27 Feb 2004 23:51:20 -0800
From: "David S. Miller" <davem@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: anton@samba.org, netdev@oss.sgi.com, linux-kernel@vger.kernel.org,
       kenneth.w.chen@intel.com, olof@austin.ibm.com
Subject: Re: [PATCH] performance problem with established hash
Message-Id: <20040227235120.72fc185a.davem@redhat.com>
In-Reply-To: <20040227195548.210f7204.akpm@osdl.org>
References: <20040228022537.GR5801@krispykreme>
	<20040227195548.210f7204.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Feb 2004 19:55:48 -0800
Andrew Morton <akpm@osdl.org> wrote:

> This should fix it up.  We keep the table sizing identical to that which
> we had in 2.6.earlier, with a boot option override.

Andrew, just push this to Linus now if you haven't already :)
