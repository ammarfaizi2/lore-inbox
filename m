Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261932AbVBIUSy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261932AbVBIUSy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 15:18:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261922AbVBIULQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 15:11:16 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:39385
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261917AbVBIUKD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 15:10:03 -0500
Date: Wed, 9 Feb 2005 12:09:11 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: sfr@canb.auug.org.au, akpm@osdl.org, linux-kernel@vger.kernel.org,
       davem@redhat.com, chrisw@osdl.org
Subject: Re: [patch, BK] clean up and unify asm-*/resource.h files
Message-Id: <20050209120911.421eb5d5.davem@davemloft.net>
In-Reply-To: <20050209180219.GC23554@elte.hu>
References: <20050209093927.GA9726@elte.hu>
	<20050210020333.7941fa6e.sfr@canb.auug.org.au>
	<20050209180219.GC23554@elte.hu>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Feb 2005 19:02:19 +0100
Ingo Molnar <mingo@elte.hu> wrote:

> New patch below.
 ...
> this patch does the final consolidation of asm-*/resource.h file,
> without changing any of the rlimit definitions on any architecture.

I'm fine with this.
