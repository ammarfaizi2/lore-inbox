Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751263AbVKNTqs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751263AbVKNTqs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 14:46:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751266AbVKNTqs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 14:46:48 -0500
Received: from wasp.net.au ([203.190.192.17]:24462 "EHLO wasp.net.au")
	by vger.kernel.org with ESMTP id S1751263AbVKNTqr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 14:46:47 -0500
Message-ID: <4378E9A8.5050807@wasp.net.au>
Date: Mon, 14 Nov 2005 23:46:48 +0400
From: Brad Campbell <brad@wasp.net.au>
User-Agent: Thunderbird 1.5 (X11/20051025)
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: George Anzinger <george@mvista.com>, john stultz <johnstul@us.ibm.com>,
       ganzinger@mvista.com, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Calibration issues with USB disc present.
References: <43750EFD.3040106@mvista.com> <1131746228.2542.11.camel@cog.beaverton.ibm.com> <20051112050502.GC27700@kroah.com> <4376130D.1080500@mvista.com> <20051112213332.GA16016@kroah.com> <4378DDC5.80103@mvista.com> <20051114184940.GA876@kroah.com>
In-Reply-To: <20051114184940.GA876@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
>>> completly, if possible.  And then complain loudly to the vendor to fix
>>> their BIOS.
>> But if one is booting from that device...
> 
> Booting from a USB device?  I can see this happening when installing a
> distro, and you boot from the USB cdrom, but not for "normal"
> operations.
> 

Just as a point of reference I have a machine here that boots from a USB keystick and runs from an 
NFS Root. It's a diskless machine that has no net-boot ability. I have used this on a number of 
machines over recent history.

Brad
-- 
"Human beings, who are almost unique in having the ability
to learn from the experience of others, are also remarkable
for their apparent disinclination to do so." -- Douglas Adams
