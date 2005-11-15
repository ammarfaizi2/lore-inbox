Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964923AbVKOR7i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964923AbVKOR7i (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 12:59:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964963AbVKOR7h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 12:59:37 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:34769 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964923AbVKOR7h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 12:59:37 -0500
Date: Tue, 15 Nov 2005 11:59:34 -0600
To: Greg KH <greg@kroah.com>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc64-dev@ozlabs.org,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] PCI Error Recovery
Message-ID: <20051115175934.GO19593@austin.ibm.com>
References: <20051108234911.GC19593@austin.ibm.com> <20051114214703.GG19593@austin.ibm.com> <20051115164901.GA12968@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051115164901.GA12968@kroah.com>
User-Agent: Mutt/1.5.6+20040907i
From: linas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2005 at 08:49:01AM -0800, Greg KH was heard to remark:
> On Mon, Nov 14, 2005 at 03:47:03PM -0600, linas wrote:
> > On Tue, Nov 08, 2005 at 05:49:11PM -0600, linas was heard to remark:
> > > 
> > > Following seven patches implement the PCI error reporting and recovery
> > > header and device driver changes as recently discussed, w/all requested
> > > changes & etc. These are tested and wrk well.  Please apply.
> > 
> > These patches don't seem to be in either linux-2.6.15-rc1-git2 or linux-2.6.15-mm2
> > 
> > Is there something else I need to do, besides nag?
> 
> Address the issue that was brought up on lkml with them?

? I'm sorry, I'm crawling the archives, and can't find any threads 
that haven't already been addressed in the final patchset.

--linas
