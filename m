Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261610AbUDISW5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Apr 2004 14:22:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261582AbUDISW5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Apr 2004 14:22:57 -0400
Received: from mail.kroah.org ([65.200.24.183]:48560 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261610AbUDISWy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Apr 2004 14:22:54 -0400
Date: Fri, 9 Apr 2004 11:22:41 -0700
From: Greg KH <greg@kroah.com>
To: Steven Walter <srwalt2@uky.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB/BlueTooth oops in 2.6.5
Message-ID: <20040409182241.GA16660@kroah.com>
References: <4076E38D.7030102@uky.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4076E38D.7030102@uky.edu>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 09, 2004 at 01:55:25PM -0400, Steven Walter wrote:
> I get a very similar oops backtrace, but from a different cause.  
> Whenever I plug in my Zaurus for the /second/ time (i.e., plug it in, 
> let usbnet find it, unplug it, then plug it in again), I get the 
> attached oops backtrace.  This did not occur with 2.6.3; unsure about 2.6.4.

Does it occur in the latest -mm kernel?

thanks,

greg k-h
