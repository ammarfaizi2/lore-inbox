Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751073AbVHKXse@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751073AbVHKXse (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 19:48:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751117AbVHKXse
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 19:48:34 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:49873 "EHLO
	pd3mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1751073AbVHKXsd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 19:48:33 -0400
Date: Thu, 11 Aug 2005 17:21:24 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Is it possible to control C.O.P
In-reply-to: <4AfFW-xN-5@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <42FBDD74.1010608@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <4AfFW-xN-5@gated-at.bofh.it>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luigi Genoni wrote:
> HI,
> there is a way that the kernel could cope with CPU Overheating Protection?
> 
> I am usng a Tyan MPX with Dual AthlonMP, but COP is configured to shutdown
> the system toot early, when the temparature is still low.

I'm guessing this is controlled by the BIOS and handled by hardware, so 
I don't know that there's much the kernel can do about it. Is there a 
threshold temperature setting in the BIOS?

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

