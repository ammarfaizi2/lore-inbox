Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263551AbTDGRP4 (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 13:15:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263562AbTDGRPz (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 13:15:55 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:61885 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S263551AbTDGRPy (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 13:15:54 -0400
Date: Mon, 7 Apr 2003 09:44:06 -0700
From: Greg KH <greg@kroah.com>
To: Jan Dittmer <j.dittmer@portrix.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] convert via686a i2c driver to sysfs
Message-ID: <20030407164406.GA2860@kroah.com>
References: <3E8D3A59.8010401@portrix.net> <20030404173250.GA1537@kroah.com> <3E8E1E91.6080503@portrix.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E8E1E91.6080503@portrix.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 05, 2003 at 02:08:49AM +0200, Jan Dittmer wrote:
> Greg KH wrote:
> >On Fri, Apr 04, 2003 at 09:55:05AM +0200, Jan Dittmer wrote:
> 
> >>So 
> >>here it goes again. Tested w/ Via KT133A board and using centiVolt and 
> >>deziDegrees. Still waiting for a final decision. My vote goes to 
> >>milliVolt and milliDegree.
> >
> >
> >I thought that was the final decision, as it's what I wrote up in the
> >Documentation/i2c/sysfs-interface document that now's in the kernel :)
> >
> >Do you want to change this patch to use those units before I apply it?
> 
> At least I missed the final decision ;-) Anyway, here it goes. Btw. 
> which other chip drivers are currently not worked on and are important? 
> So I'd convert them over the next days?

Thanks, I've applied this patch to my trees and will send it off to
Linus in a bit.

greg k-h
