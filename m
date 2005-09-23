Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750959AbVIWM5p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750959AbVIWM5p (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 08:57:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750960AbVIWM5p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 08:57:45 -0400
Received: from mail.kroah.org ([69.55.234.183]:1949 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750957AbVIWM5o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 08:57:44 -0400
Date: Fri, 23 Sep 2005 05:57:25 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: Re: GPF Using Quickcam
Message-ID: <20050923125724.GA11425@kroah.com>
References: <20050923043201.GA14899@kurtwerks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050923043201.GA14899@kurtwerks.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2005 at 12:32:01AM -0400, Kurt Wall wrote:
> Evenin' all,
> 
> I was testing out my spiffy new (to me) QuickCam Express webcam, pressed
> ^C to terminate the test, and got the GPF shown below. Kernel version
> is 2.6.12.3 running on SLAMD64:
> 
> The driver specifics are:
> 
> quickcam: QuickCam USB camera found (driver version QuickCam USB 0.6.3 $Date: 2005/04/15 19:32:49 $)
> quickcam: Kernel:2.6.13.1 bus:3 class:FF subclass:FF vendor:046D product:0870
> quickcam: Sensor HDCS-1020 detected
> quickcam: Registered device: /dev/video1

I don't see this driver in the main kernel tree.  Where did you get it
from?

thanks,

greg k-h
