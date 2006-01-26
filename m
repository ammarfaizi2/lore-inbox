Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751295AbWAZFLF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751295AbWAZFLF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 00:11:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751296AbWAZFLF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 00:11:05 -0500
Received: from mail.kroah.org ([69.55.234.183]:1218 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751295AbWAZFLE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 00:11:04 -0500
Date: Wed, 25 Jan 2006 21:10:40 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: Re: maintenance releases in GIT tree
Message-ID: <20060126051040.GA12289@kroah.com>
References: <20060126035533.GA22994@quickstop.soohrt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060126035533.GA22994@quickstop.soohrt.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2006 at 04:55:33AM +0100, Horst Schirmeier wrote:
> Hi,
> 
> why are the maintenance releases (2.6.x.y -- those with a .y in their
> version number) not stored in the git tree accessible via
> rsync://rsync1.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/?
> (Or -- are they, and I'm just not seeing them because I'm looking at the
> wrong corner in the .git/ subdirectory?)

They are not released by Linus, so why would they be in his tree?  :)

As per the release announcements, they are located in either:
	pub/scm/linux/kernel/git/gregkh/linux-2.6.15.y.git
or
	pub/scm/linux/kernel/git/chrisw/linux-2.6.15.y.git
depending on who did the release.  Check the lkml message for specifics
on which it is.

Hope this helps,

greg k-h
