Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261293AbVC0SNM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261293AbVC0SNM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 13:13:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261330AbVC0SNM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 13:13:12 -0500
Received: from mail.kroah.org ([69.55.234.183]:27800 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261293AbVC0SNF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 13:13:05 -0500
Date: Sun, 27 Mar 2005 10:12:22 -0800
From: Greg KH <greg@kroah.com>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Aaron Gyes <floam@sh.nu>, linux-kernel@vger.kernel.org
Subject: Re: Can't use SYSFS for "Proprietry" driver modules !!!.
Message-ID: <20050327181221.GB14502@kroah.com>
References: <1111886147.1495.3.camel@localhost> <490243b66dc7c3f592df7a7d0769dcb7@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <490243b66dc7c3f592df7a7d0769dcb7@mac.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 26, 2005 at 09:55:33PM -0500, Kyle Moffett wrote:
> On Mar 26, 2005, at 20:15, Aaron Gyes wrote:
> >How is what they are doing illegal? How it is even "bad"? They 
> >obviously
> >can't give up their IP. Them providing binary modules wrapped in GPL
> >glue (so anyone can fix most kernel incompatabilities) is a good thing
> >for Linux. Many people and businesses would not be using Linux if they
> >did not do that.
> 
> I think that at the moment the general consensus is that it is ok to use
> the Linux kernel APIs (but not the EXPORT_SYMBOL_GPL ones) from binary
> modules _if_ _and_ _only_ _if_ the driver was originally written 
> elsewhere and ported to the Linux kernel.  Otherwise it's a derivative
> work, and must therefore be GPLed.  Yes it's kinda draconian, but it's
> generally been for the betterment of the Open Source community.

No, that is not the general consensus at all.  Please search the
archives and the web for summaries of this discussion topic the last
time it came up.

greg k-h
