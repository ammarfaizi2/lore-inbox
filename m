Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264881AbUANXYK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 18:24:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264855AbUANXWF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 18:22:05 -0500
Received: from mail.kroah.org ([65.200.24.183]:238 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264566AbUANXVA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 18:21:00 -0500
Date: Wed, 14 Jan 2004 15:20:52 -0800
From: Greg KH <greg@kroah.com>
To: Ed Sweetman <ed.sweetman@wmich.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.1-mm3 lm_sensors outdated?
Message-ID: <20040114232052.GA9914@kroah.com>
References: <4005CB88.5000409@wmich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4005CB88.5000409@wmich.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 14, 2004 at 06:06:48PM -0500, Ed Sweetman wrote:
> sensors: numerical sysctl 7 2 1 is obsolete.
> sensors: numerical sysctl 7 2 1 is obsolete.
> 
> I now get these warnings when loading the i2c via686a and viapro modules 
>  in my dmesg output.

These warnings are coming from userspace, not the modules.

I recommend upgrading to the latest release of lmsensors (they should be
making a new release any day now to handle 2.6.1 properly.)

thanks,

greg k-h
