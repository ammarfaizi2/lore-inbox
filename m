Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262480AbVCPCnR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262480AbVCPCnR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 21:43:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262476AbVCPCnQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 21:43:16 -0500
Received: from mail.kroah.org ([69.55.234.183]:17551 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262481AbVCPCnG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 21:43:06 -0500
Date: Tue, 15 Mar 2005 18:24:04 -0800
From: Greg KH <greg@kroah.com>
To: Grant Grundler <grundler@parisc-linux.org>
Cc: "Nguyen, Tom L" <tom.l.nguyen@intel.com>,
       long <tlnguyen@snoqualmie.dp.intel.com>, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH 0/6] PCI Express Advanced Error Reporting Driver
Message-ID: <20050316022404.GA13685@kroah.com>
References: <C7AB9DA4D0B1F344BF2489FA165E5024080A4C09@orsmsx404.amr.corp.intel.com> <20050315201139.GA1756@colo.lackof.org> <20050316021207.GA6608@colo.lackof.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050316021207.GA6608@colo.lackof.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2005 at 07:12:07PM -0700, Grant Grundler wrote:
> On Tue, Mar 15, 2005 at 01:11:39PM -0700, Grant Grundler wrote:
> > Tom,
> > A co-worker made the following observation (I'm paraphrasing):
> > 	...this proposal does not deal with the Error Reporting ECN.
> > 	For example, they do not show the advisory non-fatal bit in
> > 	the correctable error status register.
> > 
> > I believe he is referring to the "Error Clarifications ECN":
> > 
> > 	http://www.pcisig.com/specifications/pciexpress/ECN_-_Error_Clarifications.pdf
> 
> Tom,
> Sorry - I got this wrong.
> He was referring to an unpublished draft "Error Reporting ECN".
> You'll have to talk to Intel's PCI-SIG representative to get a copy.
> [ Ugh. And everyone else is SOL - sorry ]

Then we have no obligation to be compliant with a unpublished spec :)

greg k-h
