Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261462AbULIFIJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261462AbULIFIJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 00:08:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261463AbULIFIJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 00:08:09 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:15038
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261462AbULIFIG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 00:08:06 -0500
Date: Wed, 8 Dec 2004 20:56:23 -0800
From: "David S. Miller" <davem@davemloft.net>
To: jt@hpl.hp.com
Cc: jt@bougret.hpl.hp.com, jgarzik@pobox.com, linux-kernel@vger.kernel.org,
       irda-users@lists.sourceforge.net
Subject: Re: IrDA patches for 2.6.10-rc3
Message-Id: <20041208205623.477d7ec1.davem@davemloft.net>
In-Reply-To: <20041209015054.GA2298@bougret.hpl.hp.com>
References: <20041209015054.GA2298@bougret.hpl.hp.com>
X-Mailer: Sylpheed version 1.0.0beta3 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Dec 2004 17:50:54 -0800
Jean Tourrilhes <jt@bougret.hpl.hp.com> wrote:

> 	There is some trivial fixes for some serious driver bug that
> did show up in my mailbox. Because the fixes are trivial and the bug
> serious, I would like to push that into 2.6.10 final.
> 	I tested the irda-usb patch, and Stephen tested the stir4200
> patch. The VIA driver case is messy : I did the minimal fix that I
> could get away with, because I don't have the hardware to test and the
> proper fix will require much more work.
> 	Just push that up ;-)

All applied, thanks Jean.
