Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261718AbTIYSZI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 14:25:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261711AbTIYSYH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 14:24:07 -0400
Received: from mail.kroah.org ([65.200.24.183]:12489 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261722AbTIYSA2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 14:00:28 -0400
Date: Thu, 25 Sep 2003 11:00:20 -0700
From: Greg KH <greg@kroah.com>
To: Milton Miller <miltonm@bga.com>, linux-kernel@vger.kernel.org,
       David Brownell <david-b@pacbell.net>
Subject: Re: USB problem. 'irq 9: nobody cared!'
Message-ID: <20030925180020.GB28876@kroah.com>
References: <200309242257.h8OMvR5d090443@sullivan.realtime.net> <20030925042326.GA6751@washoe.rutgers.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030925042326.GA6751@washoe.rutgers.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 25, 2003 at 12:23:26AM -0400, Yaroslav Halchenko wrote:
> Nop - it didn't help  :-(
> 
> http://onerussian.com/Linux/bug.USB2/dmesg
> 
> which else usefull information I can provide?

David, can you try to fix this up.  It all started with your uhci
patch...

thanks,

greg k-h
