Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422980AbWBAWUp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422980AbWBAWUp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 17:20:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422981AbWBAWUp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 17:20:45 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:19084 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1422980AbWBAWUp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 17:20:45 -0500
Date: Wed, 1 Feb 2006 16:20:40 -0600
To: Linus Torvalds <torvalds@osdl.org>
Cc: Greg KH <gregkh@suse.de>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [GIT PATCH] PCI patches for 2.6.16-rc1
Message-ID: <20060201222040.GM14705@austin.ibm.com>
References: <20060201020437.GA20719@kroah.com> <Pine.LNX.4.64.0601311813400.7301@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0601311813400.7301@g5.osdl.org>
User-Agent: Mutt/1.5.6+20040907i
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2006 at 06:16:43PM -0800, Linus Torvalds was heard to remark:
> On Tue, 31 Jan 2006, Greg KH wrote:
> > 
> > linas:
> >       PCI Hotplug: PCI panic on dlpar add (add pci slot to running partition)
> >       PCI Hotplug/powerpc: module build break
> > 
> > linas@austin.ibm.com:
> >       powerpc/PCI hotplug: remove rpaphp_find_bus()
> >       powerpc/PCI hotplug: merge config_pci_adapter
> 
> Looks like Linas Vepstas doesn't have a good email address in his From: 
> fields.. As a result, the logs are nasty. 
> 
> Linas - could you _please_ fix your email setup, of if your email setup is 
> good, could whoever added the bogus "From: " line to the email please NOT 
> DO THAT HORRIBLE THING?

(OK, I'm red with embarrassment. I can only offer that email has
been an enemy for a while now).  

Is this better?

--linas
