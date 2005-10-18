Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750824AbVJRPug@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750824AbVJRPug (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 11:50:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750825AbVJRPug
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 11:50:36 -0400
Received: from smtp.osdl.org ([65.172.181.4]:55252 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750824AbVJRPug (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 11:50:36 -0400
Date: Tue, 18 Oct 2005 08:50:18 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Ravikiran G Thirumalai <kiran@scalex86.org>
cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, discuss@x86-64.org, tglx@linutronix.de,
       shai@scalex86.org
Subject: Re: x86_64: 2.6.14-rc4 swiotlb broken
In-Reply-To: <Pine.LNX.4.64.0510180845470.3369@g5.osdl.org>
Message-ID: <Pine.LNX.4.64.0510180848540.3369@g5.osdl.org>
References: <20051017093654.GA7652@localhost.localdomain> <200510171153.56063.ak@suse.de>
 <20051017153020.GB7652@localhost.localdomain> <200510171743.47926.ak@suse.de>
 <20051017134401.3b0d861d.akpm@osdl.org> <Pine.LNX.4.64.0510171405510.3369@g5.osdl.org>
 <20051018001620.GD8932@localhost.localdomain> <Pine.LNX.4.64.0510180845470.3369@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 18 Oct 2005, Linus Torvalds wrote:
> 
> I vote for this one, assuming everybody who can test is happy.

Of course, just after sending the patch I noticed that there was a new 
version, even simpler. Can people test that one?

		Linus
