Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264177AbTCXMkS>; Mon, 24 Mar 2003 07:40:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264182AbTCXMkS>; Mon, 24 Mar 2003 07:40:18 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:59560
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264177AbTCXMkR>; Mon, 24 Mar 2003 07:40:17 -0500
Subject: Re: USB compile error with latest 2.5-bk
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Greg KH <greg@kroah.com>
Cc: Louis Garcia <louisg00@bellsouth.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030324095308.GB5934@kroah.com>
References: <1048462471.1739.1.camel@tiger>
	 <20030324095308.GB5934@kroah.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1048514654.25136.6.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 24 Mar 2003 14:04:14 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-03-24 at 09:53, Greg KH wrote:
> > drivers/usb/core/hcd.c:124: parse error before '>>' token
> > drivers/usb/core/hcd.c:124: initializer element is not constant
> > drivers/usb/core/hcd.c:124: (near initialization for
> > `usb2_rh_dev_descriptor[12]')
> 
> I don't see this error with a older compiler.  I suggest filing a bug
> with Red Hat's bugzilla.

I don't get this error with a current compiler either. Are you sure the 
patching is ok ?

