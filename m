Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269205AbUJFRZu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269205AbUJFRZu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 13:25:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269157AbUJFRZt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 13:25:49 -0400
Received: from mail.kroah.org ([69.55.234.183]:17322 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269329AbUJFRW3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 13:22:29 -0400
Date: Wed, 6 Oct 2004 10:22:01 -0700
From: Greg KH <greg@kroah.com>
To: Alan Kilian <kilian@bobodyne.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Solaris developer wants a Linux Mentor for drivers.
Message-ID: <20041006172200.GA26497@kroah.com>
References: <200410061625.i96GPVu01974@raceme.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410061625.i96GPVu01974@raceme.attbi.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 06, 2004 at 11:25:31AM -0500, Alan Kilian wrote:
> 
> 
>   Kernel folks,
> 
>     I am in the process of porting a Sun Solaris PCI bus driver
>     that I wrote over to a 2.4 kernel, and I could use a mentor
>     just to get me over the initial bumps.

Why not 2.6?  No new Linux distros are shipping 2.4 kernels anymore...

And a PCI bus driver?  What kind of hardware is this?  Is this a driver
for a pci card, or a pci bus controller?

thanks,

greg k-h
