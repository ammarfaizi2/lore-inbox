Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261447AbVF1Uic@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261447AbVF1Uic (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 16:38:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261485AbVF1Uh6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 16:37:58 -0400
Received: from smtp.osdl.org ([65.172.181.4]:27538 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261447AbVF1UfL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 16:35:11 -0400
Date: Tue, 28 Jun 2005 13:34:08 -0700
From: Chris Wright <chrisw@osdl.org>
To: Kylene Jo Hall <kjhall@us.ibm.com>
Cc: Chris Wright <chrisw@osdl.org>, Pierre Ossman <drzeus-list@drzeus.cx>,
       Bjorn Helgaas <bjorn.helgaas@hp.com>,
       LKML <linux-kernel@vger.kernel.org>, jgarzik@pobox.com,
       tpmdd-devel@lists.sourceforge.net
Subject: Re: 2.6.12 breaks 8139cp [PATCH 1 of 2]
Message-ID: <20050628203408.GA9046@shell0.pdx.osdl.net>
References: <42BA69AC.5090202@drzeus.cx> <200506231143.34769.bjorn.helgaas@hp.com> <42BB3428.6030708@drzeus.cx> <42C0EE1A.9050809@drzeus.cx> <42C1434F.2010003@drzeus.cx> <1119967788.6382.7.camel@localhost.localdomain> <42C16162.2070208@drzeus.cx> <1119971339.6382.18.camel@localhost.localdomain> <20050628172300.GE9153@shell0.pdx.osdl.net> <1119990572.6403.8.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1119990572.6403.8.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Kylene Jo Hall (kjhall@us.ibm.com) wrote:
> On Tue, 2005-06-28 at 10:23 -0700, Chris Wright wrote:
> > * Kylene Jo Hall (kjhall@us.ibm.com) wrote:
> > > 
> > > > You wouldn't happen to have just your patches available?
> > > 
> > > Here is the tpm portion of -mm patch
> > 
> > Can you narrow this down to a fix that's reasonable for -stable?
> 
> I'll be sending two patches to fix this problem.  The first one just
> changes a bunch of #define's to named emums.  The second is the real
> fix.  This was the easiest way for me, let me know if this is not ok.

Just the real fix is the best for -stable, please.

thanks,
-chris
