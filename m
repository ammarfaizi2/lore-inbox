Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268861AbUHUGMn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268861AbUHUGMn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 02:12:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268863AbUHUGMn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 02:12:43 -0400
Received: from mx1.redhat.com ([66.187.233.31]:16044 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268861AbUHUGMm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 02:12:42 -0400
Date: Fri, 20 Aug 2004 23:12:16 -0700
From: "David S. Miller" <davem@redhat.com>
To: Tomasz =?ISO-8859-1?Q?K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>
Cc: usenet-20040502@usenet.frodoid.org, miles.lane@comcast.net,
       linux-kernel@vger.kernel.org
Subject: Re: DTrace-like analysis possible with future Linux kernels?
Message-Id: <20040820231216.6e67817b.davem@redhat.com>
In-Reply-To: <Pine.LNX.4.60L.0408210520380.3003@rudy.mif.pg.gda.pl>
References: <200408191822.48297.miles.lane@comcast.net>
	<87hdqyogp4.fsf@killer.ninja.frodoid.org>
	<Pine.LNX.4.60L.0408210520380.3003@rudy.mif.pg.gda.pl>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Aug 2004 08:03:10 +0200 (CEST)
Tomasz K³oczko <kloczek@rudy.mif.pg.gda.pl> wrote:

> [1] Remember: if you want profile some part of code you mast _first_
> (re)compile them with profiling enabled.

If you use oprofile or valgrind, no you don't.

