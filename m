Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266085AbUHaBdO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266085AbUHaBdO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 21:33:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266170AbUHaBdO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 21:33:14 -0400
Received: from mx1.redhat.com ([66.187.233.31]:20678 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266085AbUHaBdN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 21:33:13 -0400
Date: Mon, 30 Aug 2004 18:33:10 -0700
From: "David S. Miller" <davem@redhat.com>
To: Ryan Cumming <ryan@spitfire.gotdns.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: TG3(Tigoon) & Kernel 2.4.27
Message-Id: <20040830183310.6cd9c88a.davem@redhat.com>
In-Reply-To: <200408301814.41346.ryan@spitfire.gotdns.org>
References: <412B5B35.7020701@apartia.fr>
	<20040825044551.GH1456@alpha.home.local>
	<20040824233648.53eb7c30.davem@redhat.com>
	<200408301814.41346.ryan@spitfire.gotdns.org>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Aug 2004 18:14:38 -0700
Ryan Cumming <ryan@spitfire.gotdns.org> wrote:

> On Tuesday 24 August 2004 23:36, you wrote:
> > I pity the poor fool who wishes to netboot his system using
> > a tg3 card and use an nfsroot with Debian.  Kind of hard to
> > get the card firmware from the filesystem in that case.
> initramfs?

Then it's a part of the kernel image.
You can't have it both ways dude.
