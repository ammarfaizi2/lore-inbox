Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751650AbWJWVC2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751650AbWJWVC2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 17:02:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751664AbWJWVC2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 17:02:28 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:44444
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751649AbWJWVC1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 17:02:27 -0400
Date: Mon, 23 Oct 2006 14:02:28 -0700 (PDT)
Message-Id: <20061023.140228.106266512.davem@davemloft.net>
To: greg@kroah.com
Cc: eiichiro.oiwa.nm@hitachi.com, alan@redhat.com, jesse.barnes@intel.com,
       linux-kernel@vger.kernel.org, steven.c.cook@intel.com,
       bjorn.helgaas@hp.com, tony.luck@intel.com
Subject: Re: pci_fixup_video change blows up on sparc64
From: David Miller <davem@davemloft.net>
In-Reply-To: <20061023183949.GA13970@kroah.com>
References: <XNM1$9$0$4$$3$3$7$A$9002718U453c5dab@hitachi.com>
	<20061023.015353.30187350.davem@davemloft.net>
	<20061023183949.GA13970@kroah.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg KH <greg@kroah.com>
Date: Mon, 23 Oct 2006 11:39:49 -0700

> On Mon, Oct 23, 2006 at 01:53:53AM -0700, David Miller wrote:
> > From: <eiichiro.oiwa.nm@hitachi.com>
> > Date: Mon, 23 Oct 2006 15:14:07 +0900
> > 
> > > Ok, I fixed, and tested on x86, x86_64 and IA64 dig.
> > > Thank you.
> > > 
> > > From: David Miller <davem@davemloft.net>
> > > Signed-off-by: Eiichiro Oiwa <eiichiro.oiwa.nm@hitachi.com>
> > 
> > Greg please apply.
> 
> Ok, but you didn't write this patch, Eiichiro did, right?
> 
> Want to get the attribution correct here.

Yes, Eiichiro did.
