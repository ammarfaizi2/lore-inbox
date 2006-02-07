Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932450AbWBGWwK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932450AbWBGWwK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 17:52:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932468AbWBGWwK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 17:52:10 -0500
Received: from smtp.osdl.org ([65.172.181.4]:3739 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932450AbWBGWwJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 17:52:09 -0500
Date: Tue, 7 Feb 2006 14:53:47 -0800
From: Andrew Morton <akpm@osdl.org>
To: Greg KH <greg@kroah.com>
Cc: linas@austin.ibm.com, paulus@samba.org, torvalds@osdl.org,
       linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, gregkh@suse.de
Subject: Re: [PATCH]: Documentation: Updated PCI Error Recovery
Message-Id: <20060207145347.72c0a77e.akpm@osdl.org>
In-Reply-To: <20060207223956.GA19009@kroah.com>
References: <20060203000602.GQ24916@austin.ibm.com>
	<20060207222144.GA15622@kroah.com>
	<20060207143052.19978ca7.akpm@osdl.org>
	<20060207223956.GA19009@kroah.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> wrote:
>
> On Tue, Feb 07, 2006 at 02:30:52PM -0800, Andrew Morton wrote:
> > Greg KH <greg@kroah.com> wrote:
> > >
> > > On Thu, Feb 02, 2006 at 06:06:02PM -0600, Linas Vepstas wrote:
> > > > 
> > > > I'm not sure who I'm addressing this patch to: Linus, maybe?
> > > > 
> > > > Please apply. Fingers crossed, I hope this may make it into 2.6.16.
> > > 
> > > This does not apply to the current tree, what kernel did you do it
> > > against?
> > > 
> > > Care to respin it against the latest -git release?
> > > 
> > 
> > err, I already merged it.  Saw "documentation" and leapt on it ;)
> 
> Ah, nevermind then...  For some reason patch didn't say it looked like
> it had already been applied, otherwise I would have caught that...
> 

It could be all the newly-added trailing whitespace I chopped off.
`patch -p1 -R -l --dry-run'.
