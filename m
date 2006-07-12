Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932189AbWGLEYl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932189AbWGLEYl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 00:24:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932412AbWGLEYk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 00:24:40 -0400
Received: from ns.suse.de ([195.135.220.2]:8941 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932189AbWGLEYk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 00:24:40 -0400
Date: Tue, 11 Jul 2006 21:20:20 -0700
From: Greg KH <greg@kroah.com>
To: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
       linux-pci maillist <linux-pci@atrey.karlin.mff.cuni.cz>,
       Tom Long Nguyen <tom.l.nguyen@intel.com>
Subject: Re: [PATCH 1/6] PCI-Express AER implemetation
Message-ID: <20060712042020.GB20793@kroah.com>
References: <1152668200.28493.178.camel@ymzhang-perf.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1152668200.28493.178.camel@ymzhang-perf.sh.intel.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2006 at 09:36:40AM +0800, Zhang, Yanmin wrote:
> I changed a little about the patches, so resend and cc to Greg.
> 
> Greg,
> 
> Could you consider for your testing tree?

Oh, and also please change the Subject lines with good descriptions of
what the individual patches do.  Having them all the same isn't ok.

thanks,

greg k-h
