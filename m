Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262875AbVFWI2y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262875AbVFWI2y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 04:28:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263226AbVFWIWW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 04:22:22 -0400
Received: from mail.kroah.org ([69.55.234.183]:1699 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262352AbVFWHLt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 03:11:49 -0400
Date: Thu, 23 Jun 2005 00:11:33 -0700
From: Greg KH <greg@kroah.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Git Mailing List <git@vger.kernel.org>
Subject: Re: Updated git HOWTO for kernel hackers
Message-ID: <20050623071133.GA12304@kroah.com>
References: <42BA14B8.2020609@pobox.com> <Pine.LNX.4.58.0506221853280.11175@ppc970.osdl.org> <42BA1B68.9040505@pobox.com> <Pine.LNX.4.58.0506221929430.11175@ppc970.osdl.org> <42BA271F.6080505@pobox.com> <Pine.LNX.4.58.0506222014000.11175@ppc970.osdl.org> <42BA45B1.7060207@pobox.com> <Pine.LNX.4.58.0506222225010.11175@ppc970.osdl.org> <20050623062045.GA11638@kroah.com> <Pine.LNX.4.58.0506222338290.11175@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0506222338290.11175@ppc970.osdl.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2005 at 11:51:40PM -0700, Linus Torvalds wrote:
> 
> 
> On Wed, 22 Jun 2005, Greg KH wrote:
> > 
> > Hm, that doesn't work right now.
> 
> Yeah, my suggested mod sucks.
> 
> Try the following slightly modified version instead, with
> 
> 	git fetch rsync://rsync.kernel.org/pub/scm/linux/kernel/git/chrisw/linux-2.6.12.y.git tag v2.6.12.1
> 
> and now it should work.

Yes, that patch works for me.

thanks,

greg k-h
