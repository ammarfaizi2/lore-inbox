Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263890AbTDDRXC (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 12:23:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263887AbTDDRVt (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 12:21:49 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:4494 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S263881AbTDDRTO (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Apr 2003 12:19:14 -0500
Date: Fri, 4 Apr 2003 09:32:50 -0800
From: Greg KH <greg@kroah.com>
To: Jan Dittmer <j.dittmer@portrix.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] convert via686a i2c driver to sysfs
Message-ID: <20030404173250.GA1537@kroah.com>
References: <3E8D3A59.8010401@portrix.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E8D3A59.8010401@portrix.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 04, 2003 at 09:55:05AM +0200, Jan Dittmer wrote:
> Hey,
> 
> I thought I posted this yesterday but cannot find it on the list.

I got a copy of it in my inbox, just haven't had a chance to apply it
yet.

> So 
> here it goes again. Tested w/ Via KT133A board and using centiVolt and 
> deziDegrees. Still waiting for a final decision. My vote goes to 
> milliVolt and milliDegree.

I thought that was the final decision, as it's what I wrote up in the
Documentation/i2c/sysfs-interface document that now's in the kernel :)

Do you want to change this patch to use those units before I apply it?

thanks,

greg k-h
