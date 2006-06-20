Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932597AbWFTLIn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932597AbWFTLIn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 07:08:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932598AbWFTLIn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 07:08:43 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:24025 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932597AbWFTLIm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 07:08:42 -0400
Date: Tue, 20 Jun 2006 06:08:24 -0500
From: Robin Holt <holt@sgi.com>
To: Jes Sorensen <jes@sgi.com>
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au, hugh@veritas.com,
       cotte@de.ibm.com, bjorn_helgaas@hp.com
Subject: Re: [patch] mspec
Message-ID: <20060620110824.GB3099@lnx-holt.americas.sgi.com>
References: <yq0lkrtzelk.fsf@jaguar.mkp.net> <20060619085855.277cd217.rdunlap@xenotime.net> <4497AC8D.6000808@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4497AC8D.6000808@sgi.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2006 at 10:06:37AM +0200, Jes Sorensen wrote:
> Randy.Dunlap wrote:
> > On 19 Jun 2006 05:20:23 -0400 Jes Sorensen wrote:
> 
> >> +MODULE_INFO(supported, "external");

That is a SuSE thing that keeps the tainted flag from being set.

Thanks,
Robin
