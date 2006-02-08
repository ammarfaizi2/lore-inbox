Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030434AbWBHS3V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030434AbWBHS3V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 13:29:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030433AbWBHS3V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 13:29:21 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:6558 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030434AbWBHS3U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 13:29:20 -0500
Date: Wed, 8 Feb 2006 12:29:13 -0600
To: Greg KH <greg@kroah.com>
Cc: Andrew Morton <akpm@osdl.org>, paulus@samba.org, torvalds@osdl.org,
       linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, gregkh@suse.de
Subject: Re: [PATCH]: Documentation: Updated PCI Error Recovery
Message-ID: <20060208182913.GQ24916@austin.ibm.com>
References: <20060203000602.GQ24916@austin.ibm.com> <20060207222144.GA15622@kroah.com> <20060207143052.19978ca7.akpm@osdl.org> <20060207223956.GA19009@kroah.com> <20060207145347.72c0a77e.akpm@osdl.org> <20060207231927.GB19648@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060207231927.GB19648@kroah.com>
User-Agent: Mutt/1.5.6+20040907i
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 07, 2006 at 03:19:27PM -0800, Greg KH was heard to remark:
> > It could be all the newly-added trailing whitespace I chopped off.
> 
> Yup, that was it, quilt would have stripped them off for me too.  Linas,
> please don't do this anymore...

Sorry; I'm usually good about that in code, but the Pavlovian
reaction didn't trip on docs.

--linas
