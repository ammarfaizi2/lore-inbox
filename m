Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262769AbUKTHED@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262769AbUKTHED (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 02:04:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262870AbUKTHED
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 02:04:03 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:7070
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S262769AbUKTHEC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 02:04:02 -0500
Date: Fri, 19 Nov 2004 22:47:41 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Chris Wedgwood <cw@f00f.org>
Cc: jmorris@redhat.com, Ian.Pratt@cl.cam.ac.uk, linux-kernel@vger.kernel.org,
       Steven.Hand@cl.cam.ac.uk, Christian.Limpach@cl.cam.ac.uk,
       Keir.Fraser@cl.cam.ac.uk, davem@redhat.com
Subject: Re: [6/7] Xen VMM patch set : add alloc_skb_from_cache
Message-Id: <20041119224741.5b407c00.davem@davemloft.net>
In-Reply-To: <20041120060330.GA23850@taniwha.stupidest.org>
References: <E1CVI7o-0004cT-00@mta1.cl.cam.ac.uk>
	<Xine.LNX.4.44.0411192103150.12779-100000@thoron.boston.redhat.com>
	<20041120060330.GA23850@taniwha.stupidest.org>
X-Mailer: Sylpheed version 0.9.99 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


BTW I already have Ian's patches in my 2.6.11 tree.  I have no
problem with the new interfaces, and the only reason it's not
going into 2.6.10 is that Linus wants only bug fixes.
