Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262131AbUKKKSh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262131AbUKKKSh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 05:18:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262167AbUKKKSh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 05:18:37 -0500
Received: from canuck.infradead.org ([205.233.218.70]:31748 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S262131AbUKKKSf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 05:18:35 -0500
Subject: Re: OOPS: 2.6.9
From: Arjan van de Ven <arjan@infradead.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Mark Hindley <mark@hindley.uklinux.net>, linux-kernel@vger.kernel.org
In-Reply-To: <4193243D.3000201@yahoo.com.au>
References: <20041110074851.GA9757@titan.home.hindley.uklinux.net>
	 <4191D13C.3060308@yahoo.com.au>
	 <20041111072734.GA1671@titan.home.hindley.uklinux.net>
	 <4193243D.3000201@yahoo.com.au>
Content-Type: text/plain
Message-Id: <1100168306.2646.23.camel@laptop.fenrus.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Thu, 11 Nov 2004 11:18:26 +0100
Content-Transfer-Encoding: 7bit
X-Spam-Score: 2.6 (++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (2.6 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[62.195.31.207 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[62.195.31.207 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-11-11 at 19:35 +1100, Nick Piggin wrote:
> OK, it's just that it's a pretty common path in the kernel, and if
> there was a bug there you'd be very unlucky to be the only one
> hitting it. Still, it's possible. Probably the best thing to do is
> report it if it happens again.

well he's using the nvidia binary driver... maybe that's interacting
funny....


