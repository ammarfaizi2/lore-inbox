Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268184AbUHXShI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268184AbUHXShI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 14:37:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268180AbUHXShH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 14:37:07 -0400
Received: from mx1.redhat.com ([66.187.233.31]:9137 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268184AbUHXSg4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 14:36:56 -0400
Date: Tue, 24 Aug 2004 11:36:35 -0700
From: "David S. Miller" <davem@redhat.com>
To: yoshfuji@linux-ipv6.org
Cc: jgarzik@pobox.com, netdev@oss.sgi.com, linux-kernel@vger.kernel.org,
       yoshfuji@linux-ipv6.org
Subject: Re: IPv6 oops on ifup in latest BK
Message-Id: <20040824113635.3b1a17e5.davem@redhat.com>
In-Reply-To: <20040824.172207.109934952.yoshfuji@linux-ipv6.org>
References: <412ADB20.5000901@pobox.com>
	<20040823235123.71f18c04.davem@redhat.com>
	<20040824.172207.109934952.yoshfuji@linux-ipv6.org>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Aug 2004 17:22:07 +0900 (JST)
YOSHIFUJI Hideaki / 吉藤英明 <yoshfuji@linux-ipv6.org> wrote:

> Good catch and spotting.  Please try this patch.
> Thank you.

Applied, thank you.
