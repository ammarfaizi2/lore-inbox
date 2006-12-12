Return-Path: <linux-kernel-owner+w=401wt.eu-S964841AbWLMAhs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964841AbWLMAhs (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 19:37:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964845AbWLMAhs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 19:37:48 -0500
Received: from cantor.suse.de ([195.135.220.2]:59478 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964841AbWLMAhr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 19:37:47 -0500
X-Greylist: delayed 3033 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 Dec 2006 19:37:47 EST
Date: Tue, 12 Dec 2006 15:46:55 -0800
From: Greg KH <greg@kroah.com>
To: Linas Vepstas <linas@austin.ibm.com>
Cc: gregkh@suse.de, akpm@osdl.org, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: Revised [PATCH 1/2]: define inline for test of channel error state
Message-ID: <20061212234655.GA28204@kroah.com>
References: <20061212225559.GL4329@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061212225559.GL4329@austin.ibm.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2006 at 04:55:59PM -0600, Linas Vepstas wrote:
> Greg,
> 
> Per discussion, a revised patch. Silly me, the value was already
> initialized in drivers/pci/probe.c and I'd been dragging along
> a prehistoric version of the if checks.
> 
> --linas
> 
> [PATCH 1/2]: define inline for test of pci channel error state

care to resend 2/2 also?  It's best to resend entire series, otherwise I
have to go dig for it, and it will take me a while to remember to do
that...

thanks,

greg "my inbox looks like hell" k-h
