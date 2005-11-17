Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965140AbVKQXzW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965140AbVKQXzW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 18:55:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965141AbVKQXzW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 18:55:22 -0500
Received: from mail.kroah.org ([69.55.234.183]:30392 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965140AbVKQXzW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 18:55:22 -0500
Date: Thu, 17 Nov 2005 13:56:13 -0800
From: Greg KH <greg@kroah.com>
To: kernel list <linux-kernel@vger.kernel.org>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>
Subject: Re: [linux-pm] [RFC] userland swsusp
Message-ID: <20051117215612.GA8797@kroah.com>
References: <F760B14C9561B941B89469F59BA3A8470BDD12EB@orsmsx401.amr.corp.intel.com> <20051116191051.GG2193@spitz.ucw.cz> <20051117165437.GA10402@dspnet.fr.eu.org> <20051117164451.GA27178@kroah.com> <20051117201509.GA25250@finwe.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051117201509.GA25250@finwe.eu.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2005 at 09:15:09PM +0100, Jacek Kawa wrote:
> Greg KH wrote:
> 
> > > > What unstable implementation? swsusp had very little regressions over past
> > > > year or so. Drivers were different story, but nothing changes w.r.t. drivers.
> > > Do you mean swsusp is actually supposed to work?  Suspend-to-ram,
> > > suspend-to-disk or both?
> > Both.  -to-ram depends on your video chip, but to-disk should work just
> > fine.  If not, please report bugs.
> 
> Thanks, I've just realized, that I probably forgot to CC anyone last time... 
> :)
> 
> So, may I kindly ask to look on:
> http://www.ussg.iu.edu/hypermail/linux/kernel/0511.1/1863.html ?

Care to file this in bugzilla.kernel.org and assign it to Pavel?

thanks,

greg k-h
