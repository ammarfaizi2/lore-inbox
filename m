Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261969AbVFUWkq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261969AbVFUWkq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 18:40:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262413AbVFUWfz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 18:35:55 -0400
Received: from smtp05.auna.com ([62.81.186.15]:28055 "EHLO smtp05.retemail.es")
	by vger.kernel.org with ESMTP id S262358AbVFUV65 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 17:58:57 -0400
Date: Tue, 21 Jun 2005 21:58:55 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: [GIT PATCH] Remove devfs from 2.6.12-git
To: linux-kernel@vger.kernel.org
References: <20050621062926.GB15062@kroah.com>
	<20050620235403.45bf9613.akpm@osdl.org> <20050621151019.GA19666@kroah.com>
	<20050621131132.105ea76f.akpm@osdl.org>
	<1119387122.6465.14.camel@localhost.localdomain>
	<20050621140310.4f9a0edf.akpm@osdl.org> <20050621211643.GA23168@kroah.com>
In-Reply-To: <20050621211643.GA23168@kroah.com> (from greg@kroah.com on Tue
	Jun 21 23:16:43 2005)
X-Mailer: Balsa 2.3.3
Message-Id: <1119391135l.25237l.2l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
X-Auth-Info: Auth:LOGIN IP:[83.138.212.68] Login:jamagallon@able.es Fecha:Tue, 21 Jun 2005 23:58:55 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 06.21, Greg KH wrote:
> On Tue, Jun 21, 2005 at 02:03:10PM -0700, Andrew Morton wrote:
> > Arjan van de Ven <arjanv@redhat.com> wrote:
> > >
> > > On Tue, 2005-06-21 at 13:11 -0700, Andrew Morton wrote:
> > > > Greg KH <greg@kroah.com> wrote:
> > > > >
> > > > >  Or I can wait until you go next.  I didn't want these patches in the -mm
> > > > >  tree as they would have caused you too much work to keep up to date and
> > > > >  not conflict with anything else due to the size of them.
> > > > 
> > > > What happens if we merge it and then the storm of complaints over the
> > > > ensuing four weeks makes us say "whoops, shouldna done that [yet]"?
> > > 
> > > so... disable the config option now. then wait 3 weeks. then do the
> > > rest ;)
> > 
> > That works for me?
> 
> Fine with me too.  I'll whip up a patch to do just that.
> 

Would you ship a new version of udev with all the *-devfs-* compat scripts
removed ?

--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandriva Linux release 2006.0 (Cooker) for i586
Linux 2.6.12-jam1 (gcc 4.0.1 (4.0.1-0.2mdk for Mandriva Linux release 2006.0))


