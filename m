Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263930AbUA3VPY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 16:15:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263942AbUA3VPY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 16:15:24 -0500
Received: from mx1.redhat.com ([66.187.233.31]:21741 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263930AbUA3VPR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 16:15:17 -0500
Date: Fri, 30 Jan 2004 13:14:00 -0800
From: "David S. Miller" <davem@redhat.com>
To: James Morris <jmorris@redhat.com>
Cc: jakub@redhat.com, dparis@w3works.com, linux-kernel@vger.kernel.org,
       rspchan@starhub.net.sg
Subject: Re: [CRYPTO]: Miscompiling sha256.c by gcc 3.2.3 and arch
 pentium3,4
Message-Id: <20040130131400.13190af5.davem@redhat.com>
In-Reply-To: <Xine.LNX.4.44.0401301133350.16128-100000@thoron.boston.redhat.com>
References: <20040130152835.GN31589@devserv.devel.redhat.com>
	<Xine.LNX.4.44.0401301133350.16128-100000@thoron.boston.redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Jan 2004 11:35:20 -0500 (EST)
James Morris <jmorris@redhat.com> wrote:

> Proposed patch below.  I think sha512 would have been ok, but might as 
> well make them the same.
> 
> R Chan, please test and let us know if it fixes the problem for you.

I'm putting this into my tree(s), thanks James.
