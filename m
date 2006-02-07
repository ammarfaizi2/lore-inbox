Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932401AbWBGWjr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932401AbWBGWjr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 17:39:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932409AbWBGWjr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 17:39:47 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:52698
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S932401AbWBGWjq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 17:39:46 -0500
Date: Tue, 7 Feb 2006 14:39:56 -0800
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linas@austin.ibm.com, paulus@samba.org, torvalds@osdl.org,
       linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, gregkh@suse.de
Subject: Re: [PATCH]: Documentation: Updated PCI Error Recovery
Message-ID: <20060207223956.GA19009@kroah.com>
References: <20060203000602.GQ24916@austin.ibm.com> <20060207222144.GA15622@kroah.com> <20060207143052.19978ca7.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060207143052.19978ca7.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 07, 2006 at 02:30:52PM -0800, Andrew Morton wrote:
> Greg KH <greg@kroah.com> wrote:
> >
> > On Thu, Feb 02, 2006 at 06:06:02PM -0600, Linas Vepstas wrote:
> > > 
> > > I'm not sure who I'm addressing this patch to: Linus, maybe?
> > > 
> > > Please apply. Fingers crossed, I hope this may make it into 2.6.16.
> > 
> > This does not apply to the current tree, what kernel did you do it
> > against?
> > 
> > Care to respin it against the latest -git release?
> > 
> 
> err, I already merged it.  Saw "documentation" and leapt on it ;)

Ah, nevermind then...  For some reason patch didn't say it looked like
it had already been applied, otherwise I would have caught that...

thanks,

greg k-h
