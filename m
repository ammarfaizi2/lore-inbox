Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261624AbUC3XnL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 18:43:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261671AbUC3XnL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 18:43:11 -0500
Received: from mail.kroah.org ([65.200.24.183]:54209 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261624AbUC3XnJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 18:43:09 -0500
Date: Tue, 30 Mar 2004 15:42:51 -0800
From: Greg KH <greg@kroah.com>
To: "Fr?d?ric L. W. Meunier" <1@pervalidus.net>
Cc: linux-kernel@vger.kernel.org, linux-hotplug-devel@lists.sourceforge.net
Subject: Re: udev related ? (Was Re: rmmod deadlocks with 2.6.5-rc[2,3])
Message-ID: <20040330234251.GA8549@kroah.com>
References: <Pine.LNX.4.58.0403301529590.1233@pervalidus.dyndns.org> <406996C2.4030204@reactivated.net> <Pine.LNX.4.58.0403301606180.352@pervalidus.dyndns.org> <Pine.LNX.4.58.0403301938450.1237@pervalidus.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0403301938450.1237@pervalidus.dyndns.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2004 at 07:49:11PM -0300, Fr?d?ric L. W. Meunier wrote:
> OK, I gave 2.6.3-rc3-mm1 a try and could reproduce it.

Yes, the bug is still there.  It is being activly worked on as I type
this...

And no, it's not udev related, but udev does help show the bug...

thanks,

greg k-h
