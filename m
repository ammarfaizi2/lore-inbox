Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265454AbUFVUUN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265454AbUFVUUN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 16:20:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265195AbUFVUQL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 16:16:11 -0400
Received: from mx1.redhat.com ([66.187.233.31]:19399 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265484AbUFVUPT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 16:15:19 -0400
Date: Tue, 22 Jun 2004 13:14:51 -0700
From: "David S. Miller" <davem@redhat.com>
To: Catalin BOIE <util@deuroconsult.ro>
Cc: shemminger@osdl.org, netdev@oss.sgi.com, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org, lartc@mailman.ds9a.nl
Subject: Re: [LARTC] [ANNOUNCE] sch_ooo - Out-of-order packet queue
 discipline
Message-Id: <20040622131451.3a6a5190.davem@redhat.com>
In-Reply-To: <Pine.LNX.4.60.0406222051240.17140@hosting.rdsbv.ro>
References: <Pine.LNX.4.58.0404021023140.18886@hosting.rdsbv.ro>
	<20040622084607.4996569f@dell_ss3.pdx.osdl.net>
	<Pine.LNX.4.60.0406222051240.17140@hosting.rdsbv.ro>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Jun 2004 20:52:01 +0300 (EEST)
Catalin BOIE <util@deuroconsult.ro> wrote:

> On Tue, 22 Jun 2004, Stephen Hemminger wrote:
> 
> > Maybe the delay and ooo scheduler should be merged, the both do sort of
> > the same thing.
> 
> Yes, it's true.
> I can work on a patch if you want.

You should, that would be great.
