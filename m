Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264562AbUHCAMM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264562AbUHCAMM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 20:12:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264627AbUHCAMM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 20:12:12 -0400
Received: from mx1.redhat.com ([66.187.233.31]:39596 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264562AbUHCAJx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 20:09:53 -0400
Date: Mon, 2 Aug 2004 17:08:17 -0700
From: "David S. Miller" <davem@redhat.com>
To: yoshfuji@linux-ipv6.org
Cc: suckfish@ihug.co.nz, pekkas@netcore.fi, linux-kernel@vger.kernel.org,
       yoshfuji@linux-ipv6.org, netdev@oss.sgi.com
Subject: Re: [PATCH] Trivial ipv6 fix.
Message-Id: <20040802170817.3f9be894.davem@redhat.com>
In-Reply-To: <20040802.065940.86004622.yoshfuji@linux-ipv6.org>
References: <1091434328.16469.5.camel@localhost.localdomain>
	<20040802.065940.86004622.yoshfuji@linux-ipv6.org>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 02 Aug 2004 06:59:40 -0700 (PDT)
YOSHIFUJI Hideaki / 吉藤英明 <yoshfuji@linux-ipv6.org> wrote:

> In article <1091434328.16469.5.camel@localhost.localdomain> (at Mon, 02 Aug 2004 20:12:08 +1200), Ralph Loader <suckfish@ihug.co.nz> says:
> 
> > ipv6_addr_hash doesn't do what it's comment says.  The comment was
> > probably what was intended, not that it'll make much difference in
> > practice.
> 
> Oops, David, please apply this.

Done, thanks guys.
