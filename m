Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261450AbTEUHlE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 03:41:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261544AbTEUHlE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 03:41:04 -0400
Received: from zeus.kernel.org ([204.152.189.113]:38870 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S261450AbTEUHlC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 03:41:02 -0400
Date: Wed, 21 May 2003 09:06:55 +0200
From: Manuel Estrada Sainz <ranty@debian.org>
To: Greg KH <greg@kroah.com>
Cc: David Gibson <david@gibson.dropbear.id.au>,
       Oliver Neukum <oliver@neukum.org>, LKML <linux-kernel@vger.kernel.org>,
       Simon Kelley <simon@thekelleys.org.uk>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Downing, Thomas" <Thomas.Downing@ipc.com>, jt@hpl.hp.com,
       Pavel Roskin <proski@gnu.org>
Subject: Re: request_firmware() hotplug interface, third round.
Message-ID: <20030521070655.GA2305@ranty.ddts.net>
Reply-To: ranty@debian.org
References: <20030517090705.GA16092@zax> <20030517103037.GA17576@ranty.ddts.net> <20030520052158.GD5248@zax> <20030520080740.GB26921@ranty.ddts.net> <20030521042153.GB9057@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030521042153.GB9057@kroah.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 20, 2003 at 09:21:53PM -0700, Greg KH wrote:
> On Tue, May 20, 2003 at 10:07:40AM +0200, Manuel Estrada Sainz wrote:
> >  What do you guys thing is best?
> > 
> >  a) loading
> >  b) control
> >  c) other:_____
> 
> d) Don't care.
> 
> "loading" or "control" is fine with me, as long as it's documented :)

 Once we agree on the code, I'll write some documentation for it.

 Did you guys see my last post on Saturday? It is supposed to fix all
 issues, including request_firmware_nowait() and a couple of sysfs
 patches.

 Maybe it went by unnoticed, or am I just too impatient?

 Have a nice day

 	Manuel
 

-- 
--- Manuel Estrada Sainz <ranty@debian.org>
                         <ranty@bigfoot.com>
			 <ranty@users.sourceforge.net>
------------------------ <manuel.estrada@hispalinux.es> -------------------
Let us have the serenity to accept the things we cannot change, courage to
change the things we can, and wisdom to know the difference.
