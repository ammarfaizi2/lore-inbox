Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265116AbUELQKN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265116AbUELQKN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 12:10:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265117AbUELQKN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 12:10:13 -0400
Received: from mail.kroah.org ([65.200.24.183]:16572 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265116AbUELQKJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 12:10:09 -0400
Date: Wed, 12 May 2004 08:08:18 -0700
From: Greg KH <greg@kroah.com>
To: Todd Poynor <tpoynor@mvista.com>
Cc: mochel@digitalimplant.org, linux-hotplug-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: Hotplug events for system suspend/resume
Message-ID: <20040512150818.GE10924@kroah.com>
References: <20040511010015.GA21831@dhcp193.mvista.com> <20040511230001.GA26569@kroah.com> <40A17251.2000500@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40A17251.2000500@mvista.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11, 2004 at 05:39:45PM -0700, Todd Poynor wrote:
> 
> But again, I'll let the embedded system designers jump in here if they'd 
> like to add some insight.  In both of the above cases, some ad-hoc 
> method of kernel-to-userspace notification could be used, but I am 
> trying to gauge interest in using hotplug as a generic notifier for these.

Ok, I'm not going to accept this until some people who would actually
use it step up and want to push for its inclusion.  None of this "patch
by proxy" stuff...

thanks,

greg k-h
