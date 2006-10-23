Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965012AbWJWSkf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965012AbWJWSkf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 14:40:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965013AbWJWSkf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 14:40:35 -0400
Received: from mail.kroah.org ([69.55.234.183]:44745 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965012AbWJWSke (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 14:40:34 -0400
Date: Mon, 23 Oct 2006 11:39:49 -0700
From: Greg KH <greg@kroah.com>
To: David Miller <davem@davemloft.net>
Cc: eiichiro.oiwa.nm@hitachi.com, alan@redhat.com, jesse.barnes@intel.com,
       linux-kernel@vger.kernel.org, steven.c.cook@intel.com,
       bjorn.helgaas@hp.com, tony.luck@intel.com
Subject: Re: pci_fixup_video change blows up on sparc64
Message-ID: <20061023183949.GA13970@kroah.com>
References: <XNM1$9$0$4$$3$3$7$A$9002717U4538db22@hitachi.com> <20061020.123140.48805752.davem@davemloft.net> <XNM1$9$0$4$$3$3$7$A$9002718U453c5dab@hitachi.com> <20061023.015353.30187350.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061023.015353.30187350.davem@davemloft.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2006 at 01:53:53AM -0700, David Miller wrote:
> From: <eiichiro.oiwa.nm@hitachi.com>
> Date: Mon, 23 Oct 2006 15:14:07 +0900
> 
> > Ok, I fixed, and tested on x86, x86_64 and IA64 dig.
> > Thank you.
> > 
> > From: David Miller <davem@davemloft.net>
> > Signed-off-by: Eiichiro Oiwa <eiichiro.oiwa.nm@hitachi.com>
> 
> Greg please apply.

Ok, but you didn't write this patch, Eiichiro did, right?

Want to get the attribution correct here.

thanks,

greg k-h
