Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262031AbULHFdE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262031AbULHFdE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 00:33:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262033AbULHFdE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 00:33:04 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:55473
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S262031AbULHFdB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 00:33:01 -0500
Date: Tue, 7 Dec 2004 21:30:53 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Patrick McHardy <kaber@trash.net>
Cc: tgraf@suug.ch, hadi@cyberus.ca, akpm@osdl.org, tomc@compaqnet.fr,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: Hard freeze with 2.6.10-rc3 and QoS, worked fine with 2.6.9
Message-Id: <20041207213053.6bb602c1.davem@davemloft.net>
In-Reply-To: <41B5E722.2080600@trash.net>
References: <1102380430.6103.6.camel@buffy>
	<20041206224441.628e7885.akpm@osdl.org>
	<1102422544.1088.98.camel@jzny.localdomain>
	<41B5E188.5050800@trash.net>
	<20041207170748.GF1371@postel.suug.ch>
	<41B5E722.2080600@trash.net>
X-Mailer: Sylpheed version 1.0.0beta3 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Dec 2004 18:23:46 +0100
Patrick McHardy <kaber@trash.net> wrote:

> Either one is fine with me, although I would prefer to see
> the number of ifdefs in this area going down, not up :)

I agree, therefore I applied Patrick's patch.
