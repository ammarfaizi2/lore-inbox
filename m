Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263159AbUJ1Xwn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263159AbUJ1Xwn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 19:52:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263153AbUJ1Xt4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 19:49:56 -0400
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:63375
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S263155AbUJ1Xss (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 19:48:48 -0400
Date: Thu, 28 Oct 2004 16:27:37 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Adrian Bunk <bunk@stusta.de>
Cc: dagb@cs.uit.no, jt@hpl.hp.com, irda-users@lists.sourceforge.net,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] irda/qos.c: remove an unused function
Message-Id: <20041028162737.3d2debdf.davem@davemloft.net>
In-Reply-To: <20041028222238.GP3207@stusta.de>
References: <20041028222238.GP3207@stusta.de>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok, it looks like this whole enormous set of diffs are corrupted.
They all are "patches of a patch" which won't apply correctly.

If you're going to send such a huge set of diffs out, please test
them our and make sure they do apply properly before mailing
them out.

Thanks.
