Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261555AbVCWPgc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261555AbVCWPgc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 10:36:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261637AbVCWPgb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 10:36:31 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:34993 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261555AbVCWPgN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 10:36:13 -0500
Date: Wed, 23 Mar 2005 06:00:58 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Grant Coady <grant_nospam@dodo.com.au>
Cc: linux-kernel@vger.kernel.org, mj@ucw.cz
Subject: Re: Linux 2.4.30-rc1
Message-ID: <20050323090058.GB4017@logos.cnet>
References: <20050318215513.GA25936@logos.cnet> <f9d141l8qn8od1lsnmb31snv94pjm8eldp@4ax.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9d141l8qn8od1lsnmb31snv94pjm8eldp@4ax.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 23, 2005 at 11:30:13AM +1100, Grant Coady wrote:
> Hi Marcelo,
> 
> On Fri, 18 Mar 2005 18:55:13 -0300, Marcelo Tosatti <marcelo.tosatti@cyclades.com> wrote:
> >
> >
> >Here goes the first release candidate for v2.4.30. 
> 
> drivers/pci/pci.ids is lagging http://pciids.sourceforge.net/pci.ids
> by a fair amount, >6300 lines diff 
> 
> I don't know policy on this reference, just tracked a change in kernel 
> didn't reflect in lspci and discovered kernel and pciutils have their 
> own copies of pci.ids file.

Martin Mares used to maintain pci.ids list in v2.4, last update was long ago: 

ChangeSet@1.555.44.112, 2002-08-14 18:34:28-03:00, mj@ucw.cz
  [PATCH] pci.ids for 2.4.20-pre2

  Hi Marcelo,

  After a long sleep, I'm sending another batch of PCI ID's. These include
  entries accumulated sent to me in past few months and also ID's having
  appeared in 2.5.x.


I dont have a problem with pci.ids additions given there is a demand 
for it.


