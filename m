Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267502AbUIOVXM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267502AbUIOVXM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 17:23:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267517AbUIOVTh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 17:19:37 -0400
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:7611
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S267515AbUIOVQc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 17:16:32 -0400
Date: Wed, 15 Sep 2004 14:13:46 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: alan@lxorguk.ukuu.org.uk, paul@clubi.ie, netdev@oss.sgi.com,
       leonid.grossman@s2io.com, linux-kernel@vger.kernel.org
Subject: Re: The ultimate TOE design
Message-Id: <20040915141346.5c5e5377.davem@davemloft.net>
In-Reply-To: <20040915210818.GA22649@havoc.gtf.org>
References: <4148991B.9050200@pobox.com>
	<Pine.LNX.4.61.0409152102050.23011@fogarty.jakma.org>
	<1095275660.20569.0.camel@localhost.localdomain>
	<4148A90F.80003@pobox.com>
	<20040915140123.14185ede.davem@davemloft.net>
	<20040915210818.GA22649@havoc.gtf.org>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Sep 2004 17:08:18 -0400
Jeff Garzik <jgarzik@pobox.com> wrote:

> There's nothing inherently wrong with sticking a computer running
> Linux inside another computer ;-)

And we already support that :-)

Plus we have things like TSO too but that doesn't require a full Linux
instance to realize on a networking port.
Simple silicon implements this already.
I don't see how that differs from your "big MTU" ideas.
