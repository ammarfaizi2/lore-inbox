Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261654AbUDSS0k (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 14:26:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261685AbUDSS0k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 14:26:40 -0400
Received: from mx1.redhat.com ([66.187.233.31]:58520 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261654AbUDSS0i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 14:26:38 -0400
Date: Mon, 19 Apr 2004 11:25:12 -0700
From: "David S. Miller" <davem@redhat.com>
To: Andreas Jochens <aj@andaco.de>
Cc: jgarzik@pobox.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tg3 driver - address error in TSO firmware code
Message-Id: <20040419112512.5f6bd2cd.davem@redhat.com>
In-Reply-To: <20040419181238.GA5987@andaco.de>
References: <20040418135534.GA6142@andaco.de>
	<20040418180811.0b2e2567.davem@redhat.com>
	<20040419080439.GB11586@andaco.de>
	<4083F5CE.5080008@pobox.com>
	<20040419181238.GA5987@andaco.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Apr 2004 20:12:38 +0200
Andreas Jochens <aj@andaco.de> wrote:

> While looking at the tg3.c sources I found the attached problem.

Patch applied, thanks Andreas.
