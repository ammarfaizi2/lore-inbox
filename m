Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268805AbUIQSbD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268805AbUIQSbD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 14:31:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268922AbUIQSbD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 14:31:03 -0400
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:48084
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S268805AbUIQSa4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 14:30:56 -0400
Date: Fri, 17 Sep 2004 11:27:44 -0700
From: "David S. Miller" <davem@davemloft.net>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: akpm@osdl.org, trivial@rustcorp.com.au, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: [TRIVIAL] Fix recent bug in fib_semantics.c
Message-Id: <20040917112744.190f6f3e.davem@davemloft.net>
In-Reply-To: <20040917062042.GE6523@zax>
References: <20040917062042.GE6523@zax>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks David, I'll push this upstream asap.

I can't believe in all the route testing I did I never
triggered this on my sparc64 boxes, must have been lucky :(
