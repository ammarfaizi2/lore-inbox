Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262960AbTIRE3t (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 00:29:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262963AbTIRE3t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 00:29:49 -0400
Received: from mail.kroah.org ([65.200.24.183]:25735 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262960AbTIRE3s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 00:29:48 -0400
Date: Wed, 17 Sep 2003 21:09:55 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Re: 2.6.0-test5 usbserial oops
Message-ID: <20030918040955.GB2849@kroah.com>
References: <20030911044650.GA10064@kroah.com> <20030911175755.GA13334@kroah.com> <20030911223224.GA1345@glitch.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030911223224.GA1345@glitch.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 11, 2003 at 05:32:24PM -0500, Greg Norris wrote:
> On Thu, Sep 11, 2003 at 10:57:56AM -0700, Greg KH wrote:
> > Hm, can you try the following patch and let me know if it fixes the
> > problem for you?
> > 
> > thanks,
> > 
> > greg k-h
> 
> I'm still getting an (apparently) identical oops.  I've attached the
> ksymoops output (your patch was applied for this one), along with the
> debugging messages you requested previously.  Let me know if I can
> provide any additional info.

Does this happen on 2.6.0-test5-bk3?

thanks,

greg k-h
