Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263962AbUILXaU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263962AbUILXaU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 19:30:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264098AbUILXaT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 19:30:19 -0400
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:415
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S263962AbUILXaP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 19:30:15 -0400
Date: Sun, 12 Sep 2004 16:28:47 -0700
From: "David S. Miller" <davem@davemloft.net>
To: =?ISO-8859-1?Q?Aur=E9lien_G=C9R=D4ME?= <ag@roxor.be>
Cc: linux-kernel@vger.kernel.org
Subject: Re: iMac G3 IPv6 issue
Message-Id: <20040912162847.109f1629.davem@davemloft.net>
In-Reply-To: <20040912231730.GC11293@caladan.roxor.be>
References: <20040912133936.GA11099@caladan.roxor.be>
	<1095011851.4995.54.camel@localhost.localdomain>
	<20040912155850.0e8fd0b5.davem@davemloft.net>
	<20040912231730.GC11293@caladan.roxor.be>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Sep 2004 01:17:31 +0200
Aurélien GÉRÔME <ag@roxor.be> wrote:

> The board is this:
> 0002:02:0f.0 Ethernet controller: Apple Computer Inc. UniNorth GMAC (Sun
> GEM)
> 
> So, it is Apple stuff wrapping a Sun GEM chip. The issue may come from
> that. Anyway, I am going to dig in the source code to find out.

It would be interesting if some other iMac users can reproduce
this too.

BTW, your signature is quite huge, could you trim it down
or (alternatively) not attach it when posting to this list?
Thanks a lot.
