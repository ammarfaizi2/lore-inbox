Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265045AbUFGUhb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265045AbUFGUhb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 16:37:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265044AbUFGUha
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 16:37:30 -0400
Received: from mail.kroah.org ([65.200.24.183]:19624 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265039AbUFGUhX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 16:37:23 -0400
Date: Mon, 7 Jun 2004 13:20:36 -0700
From: Greg KH <greg@kroah.com>
To: kai.engert@gmx.de
Cc: linux-kernel@vger.kernel.org, webcam@smcc.demon.nl
Subject: Re: small patch: enable pwc usb camera driver
Message-ID: <20040607202036.GA6185@kroah.com>
References: <40C466FB.1040309@kuix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40C466FB.1040309@kuix.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 07, 2004 at 03:00:43PM +0200, Kai Engert wrote:
> The attached patch enables the pwc driver included with kernel 2.6.7-rc2
> 
> It also removes the warnings during compilation.
> However, note that I blindly duplicated the release approach used by 
> other usb camera drivers, replacing the current no-op.
> 
> The driver works for me with a Logitech QuickCam Notebook Pro and 
> GnomeMeeting.

Nice, thanks, I've applied this.  It's amazing how long it took for this
to be fixed... :(

Again, thanks a lot for doing this.

greg k-h
