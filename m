Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932522AbWGIXRj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932522AbWGIXRj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 19:17:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932526AbWGIXRj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 19:17:39 -0400
Received: from ns2.suse.de ([195.135.220.15]:52650 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932522AbWGIXRi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 19:17:38 -0400
From: Andi Kleen <ak@suse.de>
To: Greg KH <greg@kroah.com>
Subject: Re: Linux v2.6.18-rc1
Date: Mon, 10 Jul 2006 01:17:30 +0200
User-Agent: KMail/1.9.3
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.64.0607052115210.12404@g5.osdl.org> <p73irm8nolj.fsf@verdi.suse.de> <20060708160233.GA4923@kroah.com>
In-Reply-To: <20060708160233.GA4923@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607100117.30052.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 08 July 2006 18:02, Greg KH wrote:
> On Sat, Jul 08, 2006 at 04:44:08PM +0200, Andi Kleen wrote:
> > Greg KH <greg@kroah.com> writes:
> > > 
> > > Perhaps, that is odd.  The scanner should default to the logged in user,
> > > right?  Please file a bug at bugzilla.novell.com and the SuSE people can
> > > work on it there.
> > 
> > I have a similar problem with my printer. But /dev/usblp0,
> > /dev/usb/lp0 don't even appear, no matter what the permissions are.
> 
> What version of udev are you using?  It works fine for me here with a
> USB printer (that's what I tested the changes with.)

udev-068git20050831-9 (from SUSE 10.0 I think) 

-Andi
