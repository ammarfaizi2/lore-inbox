Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262072AbUL1Fae@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262072AbUL1Fae (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Dec 2004 00:30:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262082AbUL1F3g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Dec 2004 00:29:36 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:52905
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S262080AbUL1F1e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Dec 2004 00:27:34 -0500
Date: Mon, 27 Dec 2004 21:26:15 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Roland Dreier <roland@topspin.com>
Cc: yoshfuji@linux-ipv6.org, linux-kernel@vger.kernel.org,
       openib-general@openib.org, akpm@osdl.org, torvalds@osdl.org,
       netdev@oss.sgi.com
Subject: Re: [PATCH][v4][0/24] Second InfiniBand merge candidate patch set
Message-Id: <20041227212615.0536c99f.davem@davemloft.net>
In-Reply-To: <52k6r3j8yp.fsf@topspin.com>
References: <200412192214.KlDxQ7icOmxHYIf0@topspin.com>
	<20041220.153845.70996857.yoshfuji@linux-ipv6.org>
	<20041227210007.398734cd.davem@davemloft.net>
	<52k6r3j8yp.fsf@topspin.com>
X-Mailer: Sylpheed version 1.0.0rc (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Dec 2004 21:19:26 -0800
Roland Dreier <roland@topspin.com> wrote:

> Dave, did you want to handle the entire merge of the whole IB stack,
> or just the net/ parts, which are pretty trivial and stand alone,
> since AF_INFINIBAND is already defined in the tree?

Send it all over.
