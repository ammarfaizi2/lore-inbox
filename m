Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262398AbVCDE0W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262398AbVCDE0W (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 23:26:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261557AbVCCTlt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 14:41:49 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:49322
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S262340AbVCCTPt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 14:15:49 -0500
Subject: Re: RFD: Kernel release numbering
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Adrian Bunk <bunk@stusta.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
       Greg KH <greg@kroah.com>, "David S. Miller" <davem@davemloft.net>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20050303170808.GG4608@stusta.de>
References: <Pine.LNX.4.58.0503021932530.25732@ppc970.osdl.org>
	 <42268749.4010504@pobox.com> <20050302200214.3e4f0015.davem@davemloft.net>
	 <42268F93.6060504@pobox.com> <4226969E.5020101@pobox.com>
	 <20050302205826.523b9144.davem@davemloft.net> <4226C235.1070609@pobox.com>
	 <20050303080459.GA29235@kroah.com> <4226CA7E.4090905@pobox.com>
	 <Pine.LNX.4.58.0503030750420.25732@ppc970.osdl.org>
	 <20050303170808.GG4608@stusta.de>
Content-Type: text/plain
Date: Thu, 03 Mar 2005 20:15:35 +0100
Message-Id: <1109877336.4032.47.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 (2.0.3-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-03-03 at 18:08 +0100, Adrian Bunk wrote:

> This only attacks part of the problem.

It still does not solve the problem of "untested" releases. Users will
still ignore the linus-tree-rcX kernels. 

So we move the real -rcX phase after the so called stable release. 

Doing -rcX from the "sucker" tree up to a stable release makes much more
sense and would have more testers and get back lost confidence.

tglx


