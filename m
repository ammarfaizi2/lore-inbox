Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267128AbTAPR6e>; Thu, 16 Jan 2003 12:58:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267129AbTAPR6e>; Thu, 16 Jan 2003 12:58:34 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:33803
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S267128AbTAPR6d>; Thu, 16 Jan 2003 12:58:33 -0500
Subject: Re: [PATCH 2.5.58] new NUMA scheduler: fix
From: Robert Love <rml@tech9.net>
To: Erich Focht <efocht@ess.nec.de>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>,
       Andrew Theurer <habanero@us.ibm.com>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>,
       Christoph Hellwig <hch@infradead.org>
In-Reply-To: <200301161747.14863.efocht@ess.nec.de>
References: <52570000.1042156448@flay>
	 <200301151610.43204.efocht@ess.nec.de> <23340000.1042697129@titus>
	 <200301161747.14863.efocht@ess.nec.de>
Content-Type: text/plain
Organization: 
Message-Id: <1042740441.826.55.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 16 Jan 2003 13:07:22 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-01-16 at 11:47, Erich Focht wrote:

> Fine. This form is also nearer to the codingstyle rule: "functions
> should do only one thing" (I'm reading those more carefully now ;-)

Good ;)

This is looking good.  Thanks hch for going over it with your fine tooth
comb.

Erich and Martin, what more needs to be done prior to inclusion?  Do you
still want an exec balancer in place?

	Robert Love

