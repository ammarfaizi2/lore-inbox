Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316610AbSGBEqp>; Tue, 2 Jul 2002 00:46:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316611AbSGBEqo>; Tue, 2 Jul 2002 00:46:44 -0400
Received: from mta05ps.bigpond.com ([144.135.25.137]:60609 "EHLO
	mta05ps.bigpond.com") by vger.kernel.org with ESMTP
	id <S316610AbSGBEqn>; Tue, 2 Jul 2002 00:46:43 -0400
From: Brad Hards <bhards@bigpond.net.au>
To: Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: Happy Hacking Keyboard Lite Mk 2 USB Problems with 2.4.18.
Date: Tue, 2 Jul 2002 14:45:55 +1000
User-Agent: KMail/1.4.5
Cc: linux-kernel@vger.kernel.org
References: <200207011647.g61GlNx14474@blake.inputplus.co.uk> <200207021416.42616.bhards@bigpond.net.au> <20020702002629.A22148@devserv.devel.redhat.com>
In-Reply-To: <20020702002629.A22148@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200207021445.55603.bhards@bigpond.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Jul 2002 14:26, Pete Zaitcev wrote:
> > From: Brad Hards <bhards@bigpond.net.au>
> > Date: Tue, 2 Jul 2002 14:16:42 +1000
> >
> > > > I have an idea: remove usbkbd or make it extremely hard for newbies
> > > > to build (e.g. drop CONFIG_USB_KBD from config.in, so it would need
> > > > to be added manually if you want usbkbd).
> >
> > Unfortunately, removal has been vetoed by the USB Maintainer based on
> > the code size issue.
>
> Was it during the Randy's, JE's or Greg's reign? Their ideas
> about a direction of development were sometimes different.
Here is the latest (from Greg):

http://marc.theaimsgroup.com/?l=linux-usb-users&m=101531496915989&w=2

I may have proposed removal before - it is a bit of a pet topic. So far all I 
have done is got some strongly worded (if unread) Config.help entries in.

Brad
-- 
http://conf.linux.org.au. 22-25Jan2003. Perth, Australia. Birds in Black.
