Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267659AbUIUUf3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267659AbUIUUf3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 16:35:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267872AbUIUUf2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 16:35:28 -0400
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:53384
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S267659AbUIUUfW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 16:35:22 -0400
Date: Tue, 21 Sep 2004 13:25:16 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Florian Weimer <fw@deneb.enyo.de>
Cc: herbert@gondor.apana.org.au, paul@clubi.ie, alan@lxorguk.ukuu.org.uk,
       vph@iki.fi, toon@hout.vanvergehaald.nl, admin@wolfpaw.net,
       kaukasoi@elektroni.ee.tut.fi, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.27 SECURITY BUG - TCP Local and REMOTE(verified)
 Denial of Service Attack
Message-Id: <20040921132516.50c339c8.davem@davemloft.net>
In-Reply-To: <871xgvie1y.fsf@deneb.enyo.de>
References: <E1C9aB6-0007Gk-00@gondolin.me.apana.org.au>
	<873c1bjwwj.fsf@deneb.enyo.de>
	<20040921125645.05fafd5a.davem@davemloft.net>
	<871xgvie1y.fsf@deneb.enyo.de>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Sep 2004 22:04:41 +0200
Florian Weimer <fw@deneb.enyo.de> wrote:

> > Why would it be off by default?
> 
> Probably because PMTUD is just a DRAFT STANDARD,

RFC1191 doesn't look like a draft to me.
