Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263589AbVCEEfE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263589AbVCEEfE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 23:35:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263405AbVCDXmO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 18:42:14 -0500
Received: from fire.osdl.org ([65.172.181.4]:6051 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263268AbVCDVyE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 16:54:04 -0500
Date: Fri, 4 Mar 2005 13:54:02 -0800
From: Andrew Morton <akpm@osdl.org>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, chrisw@osdl.org, torvalds@osdl.org
Subject: Re: Linux 2.6.11.1
Message-Id: <20050304135402.268e3865.akpm@osdl.org>
In-Reply-To: <20050304214309.GA898@kroah.com>
References: <20050304175302.GA29289@kroah.com>
	<20050304124431.676fd7cf.akpm@osdl.org>
	<20050304205842.GA32232@kroah.com>
	<20050304131537.7039ca10.akpm@osdl.org>
	<20050304214309.GA898@kroah.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> wrote:
>
> On Fri, Mar 04, 2005 at 01:15:37PM -0800, Andrew Morton wrote:
> > Greg KH <greg@kroah.com> wrote:
> > >
> > > > Here's the list of things which we might choose to put into 2.6.11.2.  I was
> > >  > planning on sending them in for 2.6.12 when that was going to be
> > >  > errata-only.
> > > 
> > >  Ok, care to forward them on?
> > 
> > Sure.  How do they get to Linus?
> 
> Hm, either he pulls them from our new 2.6.x.y tree, or they go to him
> through you.  Either way, I'd recommend sending them to him for now,

We can do that.  As long as the patches remain unaltered I assume that BK
will recognise that the patch is already there, in a different cset?

> until we get this whole "procedure" worked out.

Yup.  That's why I'm running this little experiment.  Applying stimuli and
seeing how we respond.  Yum, cheese.
