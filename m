Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261631AbUC3ITw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 03:19:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263436AbUC3ITv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 03:19:51 -0500
Received: from waldorf.cs.uni-dortmund.de ([129.217.4.42]:40368 "EHLO
	waldorf.cs.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S261631AbUC3ITa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 03:19:30 -0500
Date: Tue, 30 Mar 2004 10:19:28 +0200
From: Christoph Pleger <Christoph.Pleger@uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6 Hotplugging
Message-Id: <20040330101928.1e016c65.Christoph.Pleger@uni-dortmund.de>
In-Reply-To: <20040324191825.GA24854@kroah.com>
References: <20040324181021.2d495742.Christoph.Pleger@uni-dortmund.de>
	<20040324191825.GA24854@kroah.com>
Organization: Universitaet Dortmund
X-Mailer: Sylpheed version 0.8.5 (GTK+ 1.2.10; sparc-sun-solaris2.6)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Greg KH <greg@kroah.com> wrote:

> On Wed, Mar 24, 2004 at 06:10:21PM +0100, Christoph Pleger wrote:
> > Hello,
> > 
> > I am using Kernel 2.6.4 and the newest hotplug software from
> > ftp.kernel.org. When I hotplug a usb mass storage device, I get a
> > message like "disk at
> > /devices/pci0000:00/0000:00:1d.0/usb1/1-2/1-2:1.0/host1/1:0:0:0" on
> > tty1.
> > 
> > Where does this message come from and how can I prevent it from
> > appearing? Of course I do not want such a message because it
> > corrupts the text for example in the vi editor.
> 
> It's a bug in the current hotplug scripts.  Either back down to the
> previous version (as the latest was only a development release), or
> wait till I release a new version later this week.

I found the new release 2004-03-29 on ftp.kernel.org and tested it. I
still get the message I mentioned above.

Christoph
