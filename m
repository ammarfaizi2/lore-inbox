Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266219AbUHWUH2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266219AbUHWUH2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 16:07:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266081AbUHWUHP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 16:07:15 -0400
Received: from fw.osdl.org ([65.172.181.6]:52892 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267310AbUHWS7r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 14:59:47 -0400
Date: Mon, 23 Aug 2004 11:57:02 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: dhowells@redhat.com, rjw@sisk.pl, linux-kernel@vger.kernel.org
Subject: Re: 2.6.8.1-mm4 (strange behavior on dual Opteron w/ NUMA)
Message-Id: <20040823115702.4084afac.rddunlap@osdl.org>
In-Reply-To: <20040823112718.628eb84e.akpm@osdl.org>
References: <200408221620.00692.rjw@sisk.pl>
	<20040822013402.5917b991.akpm@osdl.org>
	<798.1093274973@redhat.com>
	<20040823084640.1195f4f3.rddunlap@osdl.org>
	<20040823112718.628eb84e.akpm@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Aug 2004 11:27:18 -0700 Andrew Morton wrote:

| "Randy.Dunlap" <rddunlap@osdl.org> wrote:
| >
| > This oops is fixed by this trivial patch:
| > 
| >  http://marc.theaimsgroup.com/?l=linux-kernel&m=109313574928853&w=2
| 
| But that patch was in -mm4.

Yup.  Alexander Nyberg just posted an x86-64 patch.  I missed
those bits.   :(

(His patch is in this thread:
Subject: Re: 2.6.8.1-mm IRQ routing problems)

--
~Randy
