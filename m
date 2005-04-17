Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261505AbVDQUmV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261505AbVDQUmV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Apr 2005 16:42:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261526AbVDQUkW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Apr 2005 16:40:22 -0400
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:32199
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261527AbVDQUi0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Apr 2005 16:38:26 -0400
Date: Sun, 17 Apr 2005 13:32:52 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Daniel Jacobowitz <dan@debian.org>
Cc: ikebe.takashi@lab.ntt.co.jp, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i386 & x86_64: Live Patching Funcion on 2.6.11.7
Message-Id: <20050417133252.353a5666.davem@davemloft.net>
In-Reply-To: <20050417185143.GA5002@nevyn.them.org>
References: <4261DC62.1070300@lab.ntt.co.jp>
	<20050416234439.5464e188.davem@davemloft.net>
	<20050417185143.GA5002@nevyn.them.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Apr 2005 14:51:43 -0400
Daniel Jacobowitz <dan@debian.org> wrote:

> Takashi-san's description was not very clear, but it sounds like it's a
> patching mechanism for userspace applications - not for kernel space.
> So kprobes would not be a good fit.

I saw the presentation of this stuff at the Linux Kernel conference
last year in Tokyo.  I'm pretty sure it's for the kernel. :-)
