Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263493AbTEIVqk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 17:46:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263496AbTEIVqh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 17:46:37 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:1940 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263493AbTEIVqd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 17:46:33 -0400
Date: Fri, 9 May 2003 15:00:37 -0700
From: Greg KH <greg@kroah.com>
To: Mark McClelland <mark@alpha.dyndns.org>
Cc: Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] i2c #3/3: add class field to i2c_adapter
Message-ID: <20030509220037.GB2802@kroah.com>
References: <20030506193430.GA865@bytesex.org> <20030506194018.GB865@bytesex.org> <20030506195154.GC865@bytesex.org> <3EB8DC28.8040206@alpha.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EB8DC28.8040206@alpha.dyndns.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 07, 2003 at 03:12:56AM -0700, Mark McClelland wrote:
> I've attached a patch that adds classes for analog and digital cameras 
> (webcams, etc...). I plan to submit one such driver in the next few days.
> 
> The patch also fixes a typo ("DIGINAL").

I've applied this, thanks.

greg k-h
