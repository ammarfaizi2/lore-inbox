Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261478AbVB0T2t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261478AbVB0T2t (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 14:28:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261477AbVB0T2s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 14:28:48 -0500
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:3210
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261478AbVB0T2p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 14:28:45 -0500
Date: Sun, 27 Feb 2005 11:27:12 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: kaigai@ak.jp.nec.com, akpm@osdl.org, davem@redhat.com, jlan@sgi.com,
       lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] Re: A common layer for Accounting packages
Message-Id: <20050227112712.4ade67ac.davem@davemloft.net>
In-Reply-To: <20050227140355.GA23055@logos.cnet>
References: <42168D9E.1010900@sgi.com>
	<20050218171610.757ba9c9.akpm@osdl.org>
	<421993A2.4020308@ak.jp.nec.com>
	<421B955A.9060000@sgi.com>
	<421C2B99.2040600@ak.jp.nec.com>
	<421CEC38.7010008@sgi.com>
	<421EB299.4010906@ak.jp.nec.com>
	<20050224212839.7953167c.akpm@osdl.org>
	<20050227094949.GA22439@logos.cnet>
	<4221E548.4000008@ak.jp.nec.com>
	<20050227140355.GA23055@logos.cnet>
X-Mailer: Sylpheed version 1.0.1 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Feb 2005 11:03:55 -0300
Marcelo Tosatti <marcelo.tosatti@cyclades.com> wrote:

> Yep, the netlink people should be able to help - they known what would be
> required for not sending messages in case there is no listener registered.

Please CC: netdev@oss.sgi.com to get some netlink discussions
going if wanted.
