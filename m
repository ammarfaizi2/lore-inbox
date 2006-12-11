Return-Path: <linux-kernel-owner+w=401wt.eu-S935217AbWLKO1Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935217AbWLKO1Q (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 09:27:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935310AbWLKO1Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 09:27:16 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:9441 "EHLO
	pd2mo2so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935217AbWLKO1P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 09:27:15 -0500
Date: Mon, 11 Dec 2006 08:27:05 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: NULL pointer and EIP errors
In-reply-to: <1165837291.295148.172750@j72g2000cwa.googlegroups.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: mittglobal@gmail.com
Message-id: <457D6AB9.1050506@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <1165837291.295148.172750@j72g2000cwa.googlegroups.com>
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mittglobal@gmail.com wrote:
> Hi Guys,
> 
> I have a box running Fedora 2.6.5-1.358smp. Recently DNS and SMTP went
> down on the box and both had to be restarted. I got the following
> errors in the logs but dont have a clue what they mean.
> 
> Any help from you wonderful people would be most appreciated as this is
> the second time these services have died on the box!!
> 
> Does the box need patching or do certain services need updates?

That's an ancient kernel, you should update. Also, you'd better reboot 
as the box is probably in a hosed state now that the kernel has oopsed..

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

