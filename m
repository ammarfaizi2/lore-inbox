Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161025AbVLJSXV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161025AbVLJSXV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Dec 2005 13:23:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161024AbVLJSXV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Dec 2005 13:23:21 -0500
Received: from mail.kroah.org ([69.55.234.183]:33993 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161025AbVLJSXU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Dec 2005 13:23:20 -0500
Date: Sat, 10 Dec 2005 10:16:41 -0800
From: Greg KH <greg@kroah.com>
To: mahashakti89 <mahashakti89@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: udev problem ...
Message-ID: <20051210181640.GA8245@kroah.com>
References: <439A9973.6050009@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <439A9973.6050009@wanadoo.fr>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 10, 2005 at 10:01:39AM +0100, mahashakti89 wrote:
> 
> Hi !
> 
> Here is a report bug I posted on bugs@debian.org , we'll make it short ,
> I cannot activate udev at boot , if I do this  I get IDE errors on both
> harddisks and if I can enter an X-session, I cannot open a terminal : I
> get following error message :
> "there was a problem with the child process of this terminal" . If I
> desactivate udev at boot, eveything is going O.K.
> The Debian package maintainer thinks it looks like a kernel bug ....
> This is why I am posting here hoping for help in this matter.

Can you try the 2.6.15-rc5 kernel release to see if this is better?

thanks,

greg k-h
