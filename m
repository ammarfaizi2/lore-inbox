Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272332AbTG3XdL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 19:33:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272339AbTG3XdA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 19:33:00 -0400
Received: from mail.kroah.org ([65.200.24.183]:19595 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S272332AbTG3XbV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 19:31:21 -0400
Date: Wed, 30 Jul 2003 16:16:44 -0700
From: Greg KH <greg@kroah.com>
To: Fedor Karpelevitch <fedor@karpelevitch.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.60-test2 oops on unloading ohci-hcd
Message-ID: <20030730231644.GA5491@kroah.com>
References: <200307300712.00815.fedor@karpelevitch.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307300712.00815.fedor@karpelevitch.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 30, 2003 at 07:12:00AM -0700, Fedor Karpelevitch wrote:
> with 2.6.0-test2 I am getting this oops every time I shut down, is 
> this a known problem?

It's just a warning, not an oops.  And yes, it's a known problem, I have
a fix for it in the usb tree and will send it to Linus in a few days.

thanks,

greg k-h
