Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751138AbVKKUOY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751138AbVKKUOY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 15:14:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751140AbVKKUOY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 15:14:24 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:27831 "EHLO
	pd5mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1751138AbVKKUOX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 15:14:23 -0500
Date: Fri, 11 Nov 2005 14:14:18 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: kernel crash debugging
In-reply-to: <56Z7S-85a-29@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <4374FB9A.4020400@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <56Z7S-85a-29@gated-at.bofh.it>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee wrote:
> Hello,
> 
> I am running kernel version '2.6.13-gentoo-r3'
> 
> My hardware is as follows:
>  - motherboard:  Tyan Tiger 230T
>  - processors: 2 Pentium II 1.13Ghz
>  - memory: 1.5GB 
> 
> I have been having intermittent lockups for a while now.
> 
> At first, I thought it had something to do with vmware, but this is no occuring with a non-tainted kernel.

First thing I would try with those kind of faults is Memtest86, you 
could have some bad RAM or bad memory timing settings..

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

