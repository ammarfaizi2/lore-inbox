Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266011AbUFDVco@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266011AbUFDVco (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 17:32:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266017AbUFDVcn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 17:32:43 -0400
Received: from mx1.redhat.com ([66.187.233.31]:5341 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266014AbUFDVbk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 17:31:40 -0400
Date: Fri, 4 Jun 2004 14:29:28 -0700
From: "David S. Miller" <davem@redhat.com>
To: "Wesley W. Terpstra" <terpstra@gkec.tu-darmstadt.de>
Cc: yoshfuji@linux-ipv6.org, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: Broken? 2.6.6 + IP_ADD_SOURCE_MEMBERSHIP + SO_REUSEADDR
Message-Id: <20040604142928.0d9045ce.davem@redhat.com>
In-Reply-To: <20040604212916.GA6683@muffin>
References: <20040604155423.GA5656@muffin>
	<20040605.015544.102223977.yoshfuji@linux-ipv6.org>
	<20040604212916.GA6683@muffin>
X-Mailer: Sylpheed version 0.9.11 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Jun 2004 23:29:16 +0200
"Wesley W. Terpstra" <terpstra@gkec.tu-darmstadt.de> wrote:

> I am amazed you fixed it so fast!
> Will this make it into 2.6.7?

Yes, and 2.4.27 hopefully as well.

