Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268737AbUIGWzQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268737AbUIGWzQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 18:55:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268752AbUIGWzP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 18:55:15 -0400
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:51906
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S268737AbUIGWyc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 18:54:32 -0400
Date: Tue, 7 Sep 2004 15:51:48 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Thor Kooda <tkooda-patch-kernel@devsec.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.8.1 crypto: tea.c xtea_encrypt should use
 XTEA_DELTA
Message-Id: <20040907155148.080dbca6.davem@davemloft.net>
In-Reply-To: <20040907222622.GA15730@rock>
References: <20040903223458.GD18362@rock>
	<20040907134141.6c634f26.davem@davemloft.net>
	<20040907222622.GA15730@rock>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Sep 2004 17:26:22 -0500
Thor Kooda <tkooda-patch-kernel@devsec.org> wrote:

> On Tue, 07 Sep 2004, David S. Miller wrote:
> > Thor, your patches do not apply because your email
> > client turns tab characters into spaces, please fix
> > this up.
> 
> Fixed.

Thank you, both 2.4.x and 2.6.x patches applied
