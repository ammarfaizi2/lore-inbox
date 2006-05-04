Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030283AbWEDXoM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030283AbWEDXoM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 19:44:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030284AbWEDXoM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 19:44:12 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:21356 "EHLO
	pd2mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1030283AbWEDXoL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 19:44:11 -0400
Date: Thu, 04 May 2006 17:43:41 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: x86_64 invalid opcode
In-reply-to: <68Sjn-7MD-19@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: cperkins@OCF.Berkeley.EDU
Message-id: <445A91AD.3010908@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <68Sjn-7MD-19@gated-at.bofh.it>
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

chris perkins wrote:
> hi - i'm running the 2.6.16.13 x86_64 kernel on an athlon 64 and 
> periodically get invalid opcode and general protection faults.  the 
> system continues to run for about 10 minutes following this and then 
> crashes. i've had similar problems with previous 2.6 kernels but 
> unfortunately don't have a capture of the output. below is the syslog 
> output and my .config... has anyone else seen anything similar?
> thanks,
>   chris perkins

This could be caused by problems with your RAM, have you tried running 
memtest86?

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

