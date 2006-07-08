Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964878AbWGHQDq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964878AbWGHQDq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 12:03:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964880AbWGHQDp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 12:03:45 -0400
Received: from mail.kroah.org ([69.55.234.183]:2009 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964878AbWGHQDp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 12:03:45 -0400
Date: Sat, 8 Jul 2006 09:02:33 -0700
From: Greg KH <greg@kroah.com>
To: Andi Kleen <ak@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.6.18-rc1
Message-ID: <20060708160233.GA4923@kroah.com>
References: <Pine.LNX.4.64.0607052115210.12404@g5.osdl.org> <44AD680B.9090603@unsolicited.net> <20060706221747.GA2632@kroah.com> <p73irm8nolj.fsf@verdi.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p73irm8nolj.fsf@verdi.suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 08, 2006 at 04:44:08PM +0200, Andi Kleen wrote:
> Greg KH <greg@kroah.com> writes:
> > 
> > Perhaps, that is odd.  The scanner should default to the logged in user,
> > right?  Please file a bug at bugzilla.novell.com and the SuSE people can
> > work on it there.
> 
> I have a similar problem with my printer. But /dev/usblp0,
> /dev/usb/lp0 don't even appear, no matter what the permissions are.

What version of udev are you using?  It works fine for me here with a
USB printer (that's what I tested the changes with.)

thanks,

greg k-h
