Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261440AbTCYEWX>; Mon, 24 Mar 2003 23:22:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261442AbTCYEWX>; Mon, 24 Mar 2003 23:22:23 -0500
Received: from mail207.mail.bellsouth.net ([205.152.58.147]:1300 "EHLO
	imf43bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S261440AbTCYEWW>; Mon, 24 Mar 2003 23:22:22 -0500
Subject: Re: USB compile error with latest 2.5-bk
From: Louis Garcia <louisg00@bellsouth.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1048514654.25136.6.camel@irongate.swansea.linux.org.uk>
References: <1048462471.1739.1.camel@tiger>
	 <20030324095308.GB5934@kroah.com>
	 <1048514654.25136.6.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain
Organization: 
Message-Id: <1048566820.2455.1.camel@tiger>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-3) 
Date: 24 Mar 2003 23:33:40 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

just recompiled 2.5.66 and went fine. I must have messed a patch up.

--Lou

On Mon, 2003-03-24 at 09:04, Alan Cox wrote:
> On Mon, 2003-03-24 at 09:53, Greg KH wrote:
> > > drivers/usb/core/hcd.c:124: parse error before '>>' token
> > > drivers/usb/core/hcd.c:124: initializer element is not constant
> > > drivers/usb/core/hcd.c:124: (near initialization for
> > > `usb2_rh_dev_descriptor[12]')
> > 
> > I don't see this error with a older compiler.  I suggest filing a bug
> > with Red Hat's bugzilla.
> 
> I don't get this error with a current compiler either. Are you sure the 
> patching is ok ?
> 

