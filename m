Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266362AbUBQSHi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 13:07:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266398AbUBQSHi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 13:07:38 -0500
Received: from mx1.redhat.com ([66.187.233.31]:11909 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266362AbUBQSHh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 13:07:37 -0500
Date: Tue, 17 Feb 2004 10:07:19 -0800
From: "David S. Miller" <davem@redhat.com>
To: Martin Hicks <mort@wildopensource.com>
Cc: akpm@osdl.org, rusty@rustcorp.com.au, steiner@sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Reduce TLB flushing during process migration
Message-Id: <20040217100719.734011b6.davem@redhat.com>
In-Reply-To: <20040217154926.GI12142@localhost>
References: <20040217154926.GI12142@localhost>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Feb 2004 10:49:26 -0500
Martin Hicks <mort@wildopensource.com> wrote:

> Another optimization patch from Jack Steiner, intended to reduce TLB
> flushes during process migration.

I like this change a lot.
