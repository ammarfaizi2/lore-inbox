Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262394AbVFUVTt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262394AbVFUVTt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 17:19:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262497AbVFUVSB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 17:18:01 -0400
Received: from smtp.osdl.org ([65.172.181.4]:9892 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262336AbVFUVDj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 17:03:39 -0400
Date: Tue, 21 Jun 2005 14:03:10 -0700
From: Andrew Morton <akpm@osdl.org>
To: arjanv@redhat.com
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, greg@kroah.com
Subject: Re: [GIT PATCH] Remove devfs from 2.6.12-git
Message-Id: <20050621140310.4f9a0edf.akpm@osdl.org>
In-Reply-To: <1119387122.6465.14.camel@localhost.localdomain>
References: <20050621062926.GB15062@kroah.com>
	<20050620235403.45bf9613.akpm@osdl.org>
	<20050621151019.GA19666@kroah.com>
	<20050621131132.105ea76f.akpm@osdl.org>
	<1119387122.6465.14.camel@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjanv@redhat.com> wrote:
>
> On Tue, 2005-06-21 at 13:11 -0700, Andrew Morton wrote:
> > Greg KH <greg@kroah.com> wrote:
> > >
> > >  Or I can wait until you go next.  I didn't want these patches in the -mm
> > >  tree as they would have caused you too much work to keep up to date and
> > >  not conflict with anything else due to the size of them.
> > 
> > What happens if we merge it and then the storm of complaints over the
> > ensuing four weeks makes us say "whoops, shouldna done that [yet]"?
> 
> so... disable the config option now. then wait 3 weeks. then do the
> rest ;)

That works for me?

