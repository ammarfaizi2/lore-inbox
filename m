Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271681AbTGRCRW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 22:17:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271683AbTGRCRR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 22:17:17 -0400
Received: from mail.kroah.org ([65.200.24.183]:27064 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S271681AbTGRCRO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 22:17:14 -0400
Date: Thu, 17 Jul 2003 19:31:41 -0700
From: Greg KH <greg@kroah.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Hotplug Oops Re: Linux v2.6.0-test1
Message-ID: <20030718023141.GC5828@kroah.com>
References: <20030716014650.GB2681@matchmail.com> <20030716023150.GA2302@kroah.com> <20030716201512.GA1821@matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030716201512.GA1821@matchmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 16, 2003 at 01:15:12PM -0700, Mike Fedyk wrote:
> Ok, I only see it when the system is booting, and after looking at the    
> hotplug script in init.d there is different behaviour on boot, and on later   
> invocations.                               

This is really wierd.  I can't see anything strange in your logs, until
the oops :)

I also can't duplicate it here myself, sorry, I don't really have any
ideas.

greg k-h
