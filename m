Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264374AbTEGXVN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 19:21:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264343AbTEGXVK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 19:21:10 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:63413 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264374AbTEGXUF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 19:20:05 -0400
Date: Wed, 7 May 2003 16:34:06 -0700
From: Greg KH <greg@kroah.com>
To: Ricardo Galli <gallir@uib.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CPUFreq sysfs interface MIA? (since 2.5.69)
Message-ID: <20030507233406.GA4605@kroah.com>
References: <200305071809.12961.gallir@uib.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200305071809.12961.gallir@uib.es>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 07, 2003 at 06:09:12PM +0200, Ricardo Galli wrote:
> > Under both 2.5.68 and 2.5.69 the CPUFreq /sys interface seems to be
> > missing for my machine (IBM A31p), with an Intel 845 Brookdale chipset
> > and SpeedStep support.
> 
> The same here, but it worked in 2.5.68. It's a P3 Speedstep. /proc/cpufreq 
> only shows the header.

Can you let me know if the patch I just posted to lkml in this thread
fixes this for you?

thanks,

greg k-h
