Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261294AbULAGYP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261294AbULAGYP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 01:24:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261299AbULAGYP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 01:24:15 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:51908
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261294AbULAGYN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 01:24:13 -0500
Date: Tue, 30 Nov 2004 22:17:55 -0800
From: "David S. Miller" <davem@davemloft.net>
To: James Morris <jmorris@redhat.com>
Cc: bunk@stusta.de, jlcooke@certainkey.com, andrew@mcdonald.org.uk,
       kyle@debian.org, jef@linuxbe.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] cry[to/ : make some code static
Message-Id: <20041130221755.2630165b.davem@davemloft.net>
In-Reply-To: <Xine.LNX.4.44.0411291039130.6506-100000@thoron.boston.redhat.com>
References: <20041129031636.GS4390@stusta.de>
	<Xine.LNX.4.44.0411291039130.6506-100000@thoron.boston.redhat.com>
X-Mailer: Sylpheed version 1.0.0beta3 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Nov 2004 10:39:32 -0500 (EST)
James Morris <jmorris@redhat.com> wrote:

> On Mon, 29 Nov 2004, Adrian Bunk wrote:
> 
> > The patch below makes some needlessly global code static.
> 
> Looks fine to me.

I'll queue this up for 2.6.11, thanks Adrian.
