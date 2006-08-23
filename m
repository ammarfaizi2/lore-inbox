Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964783AbWHWIlu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964783AbWHWIlu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 04:41:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964788AbWHWIlu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 04:41:50 -0400
Received: from ns1.suse.de ([195.135.220.2]:45755 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964787AbWHWIlt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 04:41:49 -0400
Date: Wed, 23 Aug 2006 01:41:48 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       torvalds@osdl.org
Subject: Re: Linux 2.6.17.10
Message-ID: <20060823084148.GA18098@suse.de>
References: <20060822192727.GA8579@kroah.com> <20060823083504.GA31519@merlin.emma.line.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060823083504.GA31519@merlin.emma.line.org>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2006 at 10:35:04AM +0200, Matthias Andree wrote:
> (Removing stable@ from Cc:)
> 
> Greg KH schrieb am 2006-08-22:
> 
> > Sridhar Samudrala:
> >       Fix sctp privilege elevation (CVE-2006-3745)
> 
> I've seen gazillions of CVE numbers for SCTP over the past months.
> 
> Should perhaps SCTP be dropped from the kernel until it has been audited
> for security by at least two independent parties?

Are you willing to be one of those independent parties?

And if you haven't noticed, it seems that people are finally auditing
the thing, luckily no one really uses it in the wild :)

thanks,

greg k-h
