Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261443AbVCJDvP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261443AbVCJDvP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 22:51:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261688AbVCJDtk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 22:49:40 -0500
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:6625
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261443AbVCJDsj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 22:48:39 -0500
Date: Wed, 9 Mar 2005 19:47:44 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: bk commits and dates
Message-Id: <20050309194744.6aef66b7.davem@davemloft.net>
In-Reply-To: <1110422519.32556.159.camel@gaston>
References: <1110422519.32556.159.camel@gaston>
X-Mailer: Sylpheed version 1.0.1 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Mar 2005 13:41:59 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> I don't know if I'm the only one to have a problem with that, but it
> would be nice if it was possible, when you pull a bk tree, to have the
> commit messages for the csets in that tree be dated from the day you
> pulled, and not the day when they went in the source tree.

When I'm working, I just do "bk csets" after I pull from Linus's
tree to review what went in since the last time I pulled.
