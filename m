Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262181AbTJIN5t (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 09:57:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262177AbTJIN5t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 09:57:49 -0400
Received: from mail-13.iinet.net.au ([203.59.3.45]:45229 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S262181AbTJIN5s
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 09:57:48 -0400
Subject: Re: devfs vs. udev
From: Ian Kent <raven@themaw.net>
To: linux-kernel@vger.kernel.org
In-Reply-To: <20031007174928.GB1956@kroah.com>
References: <yw1xad8dfcjg.fsf@users.sourceforge.net>
	 <pan.2003.10.07.13.41.23.48967@dungeon.inka.de>
	 <yw1xekxpdtuq.fsf@users.sourceforge.net> <20031007142349.GX1223@rdlg.net>
	 <pan.2003.10.07.16.06.52.842471@dungeon.inka.de>
	 <20031007165404.GB29870@carfax.org.uk>  <20031007174928.GB1956@kroah.com>
Content-Type: text/plain
Organization: 
Message-Id: <1065706989.3203.2.camel@raven.themaw.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 09 Oct 2003 21:43:10 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-10-08 at 01:49, Greg KH wrote:
> On Tue, Oct 07, 2003 at 05:54:04PM +0100, Hugo Mills wrote:
> > 
> >    Surely udev needs the ability to make more than one device node or
> > symlink when a device is plugged in anyway, so I just see this as an
> > issue of writing the appropriate default configuration files.
> 
> More than one device node per device?  Why would you want that?
> 
> And sure, it's just software, it can be made to do that, if someone
> sends me a patch... :)
> 

Will udev remove the limit on the number of anonymous devices?

