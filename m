Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262965AbTLIFVj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 00:21:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262991AbTLIFVj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 00:21:39 -0500
Received: from dyn-195-242-117-208.ppp.tiscali.fr ([195.242.117.208]:38919
	"EHLO nsbm.kicks-ass.org") by vger.kernel.org with ESMTP
	id S262965AbTLIFVi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 00:21:38 -0500
Date: Tue, 9 Dec 2003 06:17:28 +0100
From: Witukind <witukind@nsbm.kicks-ass.org>
To: Greg KH <greg@kroah.com>
Cc: recbo@nishanet.com, linux-kernel@vger.kernel.org
Subject: Re: udev sysfs docs Re: State of devfs in 2.6?
Message-Id: <20031209061728.28bfaf0f.witukind@nsbm.kicks-ass.org>
In-Reply-To: <20031208233755.GC31370@kroah.com>
References: <200312081536.26022.andrew@walrond.org>
	<20031208154256.GV19856@holomorphy.com>
	<3FD4CC7B.8050107@nishanet.com>
	<20031208233755.GC31370@kroah.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Dec 2003 15:37:55 -0800
Greg KH <greg@kroah.com> wrote:

> On Mon, Dec 08, 2003 at 02:09:47PM -0500, Bob wrote:
> > William Lee Irwin III wrote:
> > 
> > >On Mon, Dec 08, 2003 at 03:36:26PM +0000, Andrew Walrond wrote:
> > > 
> > >
> > >>Whats the general feeling about devfs now? I remember Christoph
> > >and >others making some nasty remarks about it 6months ago or so,
> > >but later >noted christoph doing some slashing and burning thereof.
> > >>Is it 'nice' yet? 
> > >>Andrew Walrond
> > >>   
> > >>
> > >
> > >I would say it's deprecated at the very least. sysfs and udev are
> > >supposed to provide equivalent functionality, albeit by a somewhat
> > >different mechanism.

>From the udev FAQ:

Q: But udev will not automatically load a driver if a /dev node is opened
   when it is not present like devfs will do.
A: If you really require this functionality, then use devfs.  It is still
   present in the kernel.

Will it have this 'equivalent functionality' some day?


-- 
Jabber: heimdal@jabber.org
