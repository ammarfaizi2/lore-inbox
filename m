Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264095AbTLJVsz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 16:48:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263983AbTLJVsg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 16:48:36 -0500
Received: from mail.kroah.org ([65.200.24.183]:8332 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263946AbTLJVs2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 16:48:28 -0500
Date: Wed, 10 Dec 2003 13:31:43 -0800
From: Greg KH <greg@kroah.com>
To: Stian Jordet <liste@jordet.nu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: usbfs mount options doesn't work in 2.6, works fine with 2.4
Message-ID: <20031210213142.GB8784@kroah.com>
References: <1070859138.1882.2.camel@chevrolet.hybel> <1070859550.2001.1.camel@chevrolet.hybel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1070859550.2001.1.camel@chevrolet.hybel>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 08, 2003 at 05:59:10AM +0100, Stian Jordet wrote:
> man, 08.12.2003 kl. 05.52 skrev Stian Jordet:
> > Is this something other people are
> > experiencing as well, or is this some kind of configuration problem? I'm
> And I just found:
> 
> http://bugzilla.kernel.org/show_bug.cgi?id=1418
> 
> and
> 
> 
> http://www.ussg.iu.edu/hypermail/linux/kernel/0307.3/0666.html
> 
> Oh well. I can use my digital camera as root. No problem :P

Yeah, it's a bug.  I haven't had the time to track it down yet.  Any
help with this would be greatly appreciated.

thanks,

greg k-h
