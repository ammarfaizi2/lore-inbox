Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261313AbVA0Xxm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261313AbVA0Xxm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 18:53:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261161AbVA0XwW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 18:52:22 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:12994
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261313AbVA0XqW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 18:46:22 -0500
Date: Thu, 27 Jan 2005 15:41:50 -0800
From: "David S. Miller" <davem@davemloft.net>
To: David Brownell <david-b@pacbell.net>
Cc: jf-ml-k1-1087813225@lk8rp.mail.xeon.eu.org,
       david+challenge-response@blue-labs.org, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, ahaas@airmail.net
Subject: Re: 2.6.11-rc2 TCP ignores PMTU ICMP (Re: Linux 2.6.11-rc2)
Message-Id: <20050127154150.360f95e2.davem@davemloft.net>
In-Reply-To: <200501271511.58086.david-b@pacbell.net>
References: <200501232251.42394.david-b@pacbell.net>
	<priv$1106815487.koan@shadow.banki.hu>
	<200501271128.48411.david-b@pacbell.net>
	<200501271511.58086.david-b@pacbell.net>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've forwarded this to netfilter-devel for inspection.
Thanks for collecting all the data points so well.
