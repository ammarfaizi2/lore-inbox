Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266542AbUBLTRO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 14:17:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266563AbUBLTRO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 14:17:14 -0500
Received: from mx1.redhat.com ([66.187.233.31]:9179 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266542AbUBLTRN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 14:17:13 -0500
Date: Thu, 12 Feb 2004 11:17:07 -0800
From: "David S. Miller" <davem@redhat.com>
To: Wojciech Purczynski <cliph@isec.pl>
Cc: jgarzik@pobox.com, linux-kernel@vger.kernel.org
Subject: Re: drivers/net/tg3.h out of date in 2.4.25rc2
Message-Id: <20040212111707.43c16a54.davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0402121457520.30421-100000@isec.pl>
References: <Pine.LNX.4.44.0402121457520.30421-100000@isec.pl>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Feb 2004 15:10:43 +0100 (CET)
Wojciech Purczynski <cliph@isec.pl> wrote:

> It seems that tg3.h header file is out of date. The updated Tigon3 driver
> does not compile correctly because of few missing definitions.

Are you sure you patched your tree correctly?  It builds fine here.
