Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261454AbVCCE7m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261454AbVCCE7m (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 23:59:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261429AbVCCE7j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 23:59:39 -0500
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:52162
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261454AbVCCE6h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 23:58:37 -0500
Date: Wed, 2 Mar 2005 20:58:26 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
Message-Id: <20050302205826.523b9144.davem@davemloft.net>
In-Reply-To: <4226969E.5020101@pobox.com>
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org>
	<42264F6C.8030508@pobox.com>
	<20050302162312.06e22e70.akpm@osdl.org>
	<42265A6F.8030609@pobox.com>
	<20050302165830.0a74b85c.davem@davemloft.net>
	<422674A4.9080209@pobox.com>
	<Pine.LNX.4.58.0503021932530.25732@ppc970.osdl.org>
	<42268749.4010504@pobox.com>
	<20050302200214.3e4f0015.davem@davemloft.net>
	<42268F93.6060504@pobox.com>
	<4226969E.5020101@pobox.com>
X-Mailer: Sylpheed version 1.0.1 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 02 Mar 2005 23:46:22 -0500
Jeff Garzik <jgarzik@pobox.com> wrote:

> If Linus/DaveM really don't like -pre/-rc naming, I think 2.6.x.y is 
> preferable to even/odd.

All of these arguments are circular.  If people think that even/odd
will devalue odd releases, guess what 2.6.x.y will do?  By that line
of reasoning nobody will test 2.6.x just the same as they aren't
testing 2.6.x-rc* right now.

I think they will test the odd releases, because as a real release
they will get slashdot/lwn.net/etc. announcements.

That's one of the major things the -rc's don't get.  Maybe it gets
a reference in lwn.net's weekly kernel article, but mostly kernel
geeks read those and that's not who we want testing -rc's (such
geeks already are doing so).

It has to be a "real" release.  That does have an impact.  However,
I am ambivalent about how to make them real.  Even/odd, 2.6.x.y,
either is fine with me.
