Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263269AbTDRWJa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 18:09:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263272AbTDRWJa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 18:09:30 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:433 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S263269AbTDRWJ3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 18:09:29 -0400
Date: Fri, 18 Apr 2003 15:19:13 -0700
From: Greg KH <greg@kroah.com>
To: Frederic Lepied <flepied@mandrakesoft.com>
Cc: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [RFC] /sbin/hotplug multiplexor - take 2
Message-ID: <20030418221913.GA8703@kroah.com>
References: <20030414190032.GA4459@kroah.com> <20030414224607.GC6411@kroah.com> <m3ptnnezca.fsf@skywalker.mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3ptnnezca.fsf@skywalker.mandrakesoft.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 16, 2003 at 08:22:13AM +0200, Frederic Lepied wrote:
> Greg KH <greg@kroah.com> writes:
> 
> > Ok, based on the comments so far, how about this proposed version of
> > /sbin/hotplug to provide a multiplexor?
> 
> I think it would be good to launch only the files ending by a special
> extension to avoid running backup files. Something like that:

Ah, good idea, will do.

thanks,

greg k-h
