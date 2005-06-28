Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262086AbVF1RaD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262086AbVF1RaD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 13:30:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261508AbVF1R1u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 13:27:50 -0400
Received: from smtp.osdl.org ([65.172.181.4]:19147 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262038AbVF1R0y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 13:26:54 -0400
Date: Tue, 28 Jun 2005 10:23:00 -0700
From: Chris Wright <chrisw@osdl.org>
To: Kylene Jo Hall <kjhall@us.ibm.com>
Cc: Pierre Ossman <drzeus-list@drzeus.cx>,
       Bjorn Helgaas <bjorn.helgaas@hp.com>,
       LKML <linux-kernel@vger.kernel.org>, jgarzik@pobox.com,
       tpmdd-devel@lists.sourceforge.net
Subject: Re: 2.6.12 breaks 8139cp
Message-ID: <20050628172300.GE9153@shell0.pdx.osdl.net>
References: <42B9D21F.7040908@drzeus.cx> <200506221534.03716.bjorn.helgaas@hp.com> <42BA69AC.5090202@drzeus.cx> <200506231143.34769.bjorn.helgaas@hp.com> <42BB3428.6030708@drzeus.cx> <42C0EE1A.9050809@drzeus.cx> <42C1434F.2010003@drzeus.cx> <1119967788.6382.7.camel@localhost.localdomain> <42C16162.2070208@drzeus.cx> <1119971339.6382.18.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1119971339.6382.18.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Kylene Jo Hall (kjhall@us.ibm.com) wrote:
> 
> > You wouldn't happen to have just your patches available?
> 
> Here is the tpm portion of -mm patch

Can you narrow this down to a fix that's reasonable for -stable?

thanks,
-chris
