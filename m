Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964953AbVKORCs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964953AbVKORCs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 12:02:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964956AbVKORCs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 12:02:48 -0500
Received: from mail.kroah.org ([69.55.234.183]:49294 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964953AbVKORCr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 12:02:47 -0500
Date: Tue, 15 Nov 2005 08:49:01 -0800
From: Greg KH <greg@kroah.com>
To: linas <linas@austin.ibm.com>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc64-dev@ozlabs.org,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] PCI Error Recovery
Message-ID: <20051115164901.GA12968@kroah.com>
References: <20051108234911.GC19593@austin.ibm.com> <20051114214703.GG19593@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051114214703.GG19593@austin.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2005 at 03:47:03PM -0600, linas wrote:
> On Tue, Nov 08, 2005 at 05:49:11PM -0600, linas was heard to remark:
> > 
> > Following seven patches implement the PCI error reporting and recovery
> > header and device driver changes as recently discussed, w/all requested
> > changes & etc. These are tested and wrk well.  Please apply.
> 
> These patches don't seem to be in either linux-2.6.15-rc1-git2 or linux-2.6.15-mm2
> 
> Is there something else I need to do, besides nag?

Address the issue that was brought up on lkml with them?

thanks,

greg k-h
