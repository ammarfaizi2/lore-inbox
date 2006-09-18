Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965100AbWIRNuE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965100AbWIRNuE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 09:50:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965091AbWIRNuE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 09:50:04 -0400
Received: from mail.kroah.org ([69.55.234.183]:21724 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965100AbWIRNuC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 09:50:02 -0400
Date: Mon, 18 Sep 2006 06:39:49 -0700
From: Greg KH <greg@kroah.com>
To: Matthew Locke <matt@nomadgs.com>
Cc: pm list <linux-pm@lists.osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: PowerOP summary
Message-ID: <20060918133949.GA9495@kroah.com>
References: <330177f4f8f83d0d39034c8f05d4b1f7@nomadgs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <330177f4f8f83d0d39034c8f05d4b1f7@nomadgs.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2006 at 01:28:25AM -0700, Matthew Locke wrote:
> Summary
> PowerOP is an interface to create and select operating points.  
> Operating points are a collection of platform specific system 
> parameters (ie not i/o devices) that affect power consumption.  These 
> parameters include cpu frequency, voltages, clock sources and dividers 
> and others.  PowerOP provides a platform independent interface to 
> control these platform specific parameters.   This interface is a basic 
> building block of a power management stack for advanced power 
> management on embedded mobile devices.

Will this also work properly for 2/4/8/16/512/1024 processor machines?
They also need this kind of capability, and can not be ignored.

thanks,

greg k-h
