Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264134AbUFSTAX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264134AbUFSTAX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 15:00:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264101AbUFSTAX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 15:00:23 -0400
Received: from mx1.redhat.com ([66.187.233.31]:17872 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264134AbUFSTAT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 15:00:19 -0400
Date: Sat, 19 Jun 2004 11:59:04 -0700
From: "David S. Miller" <davem@redhat.com>
To: yoshfuji@linux-ipv6.org
Cc: andrew@walrond.org, kalin@ThinRope.net, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, netfilter-devel@lists.netfilter.org,
       yoshfuji@linux-ipv6.org
Subject: Re: Iptables-1.2.9/10 compile failure with linux 2.6.7 headers
Message-Id: <20040619115904.6cbb1736.davem@redhat.com>
In-Reply-To: <20040620.013527.55353972.yoshfuji@linux-ipv6.org>
References: <40D31EA6.5030207@ThinRope.net>
	<20040619.021818.04202102.yoshfuji@linux-ipv6.org>
	<200406191038.51118.andrew@walrond.org>
	<20040620.013527.55353972.yoshfuji@linux-ipv6.org>
X-Mailer: Sylpheed version 0.9.11 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Jun 2004 01:35:27 +0900 (JST)
YOSHIFUJI Hideaki / 吉藤英明 <yoshfuji@linux-ipv6.org> wrote:

> In article <200406191038.51118.andrew@walrond.org> (at Sat, 19 Jun 2004 10:38:50 +0100), Andrew Walrond <andrew@walrond.org> says:
> 
> > On Friday 18 Jun 2004 18:18, YOSHIFUJI Hideaki / 吉藤英明 wrote:
> > >
> > > Please try this. Thanks
> > >
> > 
> > I can confirm that iptables-1.2.10 builds fine with your patch applied to 
> > linux-2.6.7
> 
> Thanks. David?

Applied.
