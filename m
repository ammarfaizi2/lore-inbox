Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262492AbVFUVYX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262492AbVFUVYX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 17:24:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262521AbVFUVUx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 17:20:53 -0400
Received: from mail.kroah.org ([69.55.234.183]:15011 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262492AbVFUVQ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 17:16:56 -0400
Date: Tue, 21 Jun 2005 14:16:43 -0700
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>
Cc: arjanv@redhat.com, linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [GIT PATCH] Remove devfs from 2.6.12-git
Message-ID: <20050621211643.GA23168@kroah.com>
References: <20050621062926.GB15062@kroah.com> <20050620235403.45bf9613.akpm@osdl.org> <20050621151019.GA19666@kroah.com> <20050621131132.105ea76f.akpm@osdl.org> <1119387122.6465.14.camel@localhost.localdomain> <20050621140310.4f9a0edf.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050621140310.4f9a0edf.akpm@osdl.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2005 at 02:03:10PM -0700, Andrew Morton wrote:
> Arjan van de Ven <arjanv@redhat.com> wrote:
> >
> > On Tue, 2005-06-21 at 13:11 -0700, Andrew Morton wrote:
> > > Greg KH <greg@kroah.com> wrote:
> > > >
> > > >  Or I can wait until you go next.  I didn't want these patches in the -mm
> > > >  tree as they would have caused you too much work to keep up to date and
> > > >  not conflict with anything else due to the size of them.
> > > 
> > > What happens if we merge it and then the storm of complaints over the
> > > ensuing four weeks makes us say "whoops, shouldna done that [yet]"?
> > 
> > so... disable the config option now. then wait 3 weeks. then do the
> > rest ;)
> 
> That works for me?

Fine with me too.  I'll whip up a patch to do just that.

thanks,

greg k-h
