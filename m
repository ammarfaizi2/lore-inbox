Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262031AbVCOWl1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262031AbVCOWl1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 17:41:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262097AbVCOWkl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 17:40:41 -0500
Received: from colo.lackof.org ([198.49.126.79]:39555 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S261989AbVCOWgy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 17:36:54 -0500
Date: Tue, 15 Mar 2005 15:38:15 -0700
From: Grant Grundler <grundler@parisc-linux.org>
To: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH 0/6] PCI Express Advanced Error Reporting Driver
Message-ID: <20050315223815.GA3757@colo.lackof.org>
References: <C7AB9DA4D0B1F344BF2489FA165E5024080A511B@orsmsx404.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C7AB9DA4D0B1F344BF2489FA165E5024080A511B@orsmsx404.amr.corp.intel.com>
X-Home-Page: http://www.parisc-linux.org/
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2005 at 01:54:32PM -0800, Nguyen, Tom L wrote:
> On Tuesday, March 15, 2005 12:12 PM Grant Grundler wrote:
> >Tom,
> >A co-worker made the following observation (I'm paraphrasing):
> >	...this proposal does not deal with the Error Reporting ECN.
> >	For example, they do not show the advisory non-fatal bit in
> >	the correctable error status register.
> 
> Does he refer to the ECN update on the Received Error Bit[0] of the
> Correctable Error Status Register and on the Training Error Bit[0] of
> the Uncorrectable Error Status Register? If not, please clarify his
> comments for us.


Yes - I believe so.

grant
