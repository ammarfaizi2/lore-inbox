Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030422AbWASFo1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030422AbWASFo1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 00:44:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932545AbWASFo1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 00:44:27 -0500
Received: from fmr22.intel.com ([143.183.121.14]:47492 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S932543AbWASFo0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 00:44:26 -0500
Message-Id: <200601190543.k0J5hBg06542@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Andrew Morton'" <akpm@osdl.org>, "Adrian Bunk" <bunk@stusta.de>
Cc: <linux-kernel@vger.kernel.org>, "Badari Pulavarty" <pbadari@us.ibm.com>
Subject: RE: [2.6 patch] the scheduled removal of the obsolete raw driver
Date: Wed, 18 Jan 2006 21:43:12 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcYcqkbBVv2AVwZEQ6+4zHVWLRJfhAAD4tNQ
In-Reply-To: <20060118194103.5c569040.akpm@osdl.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote on Wednesday, January 18, 2006 7:41 PM
> Adrian Bunk <bunk@stusta.de> wrote:
> >
> > Let's do the scheduled removal of the obsolete raw driver in 2.6.17.
> > 
> 
> heh.  I was just thinking that I hadn't heard from Badari and Ken in a while.
> 
> I doubt if this'll fly.  We're stuck with it.


Could we please, leave the raw device driver alone.  ISV is doing
their diligent work converting new code to O_DIRECT, but large amount
of field customers are still using raw device in their setup.

- Ken

