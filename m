Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266820AbUIWUrM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266820AbUIWUrM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 16:47:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267184AbUIWUqt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 16:46:49 -0400
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:35481
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S266820AbUIWUh2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 16:37:28 -0400
Date: Thu, 23 Sep 2004 13:36:04 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: xhejtman@mail.muni.cz, akpm@osdl.org, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: 2.6.9-rc2-mm2 fn_hash_insert oops
Message-Id: <20040923133604.26a2ea2a.davem@davemloft.net>
In-Reply-To: <E1CARaS-00071j-00@gondolin.me.apana.org.au>
References: <20040923103723.GA12145@mail.muni.cz>
	<E1CARaS-00071j-00@gondolin.me.apana.org.au>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Sep 2004 21:16:32 +1000
Herbert Xu <herbert@gondor.apana.org.au> wrote:

> Lukas Hejtmanek <xhejtman@mail.muni.cz> wrote:
> > 
> > However there is still the issue with endless loop in fn_hash_delete :(
> 
> Same problem, same fix.

Applied, thanks Herbert.
