Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261980AbVCRSYm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261980AbVCRSYm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 13:24:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262006AbVCRSYm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 13:24:42 -0500
Received: from colo.lackof.org ([198.49.126.79]:46531 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S261980AbVCRSYl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 13:24:41 -0500
Date: Fri, 18 Mar 2005 11:26:09 -0700
From: Grant Grundler <grundler@parisc-linux.org>
To: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH 0/6] PCI Express Advanced Error Reporting Driver
Message-ID: <20050318182609.GA31703@colo.lackof.org>
References: <C7AB9DA4D0B1F344BF2489FA165E5024080A4C09@orsmsx404.amr.corp.intel.com> <20050315201139.GA1756@colo.lackof.org> <20050316021207.GA6608@colo.lackof.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050316021207.GA6608@colo.lackof.org>
X-Home-Page: http://www.parisc-linux.org/
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2005 at 07:12:07PM -0700, Grant Grundler wrote:
...
> He was referring to an unpublished draft "Error Reporting ECN".
> You'll have to talk to Intel's PCI-SIG representative to get a copy.

Good News: the "Error Reporting ECN" is now posted on the PCISIG website.

	http://www.pcisig.com/specifications/pciexpress/specifications/ECN_Error_Reporting_050127_clean.pdf

Tom, please review and see if/how that changes your implementation.

thanks,
grant
