Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965175AbWADDFN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965175AbWADDFN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 22:05:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965177AbWADDFN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 22:05:13 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:11592 "EHLO
	pd5mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S965175AbWADDFL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 22:05:11 -0500
Date: Tue, 03 Jan 2006 21:03:16 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: X86_64 + VIA + 4g problems
In-reply-to: <5r2nz-63n-233@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <43BB3AF4.5000402@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <5qvTv-8f-17@gated-at.bofh.it> <5qAKf-7n4-19@gated-at.bofh.it>
 <5qBcJ-7ZZ-5@gated-at.bofh.it> <5qDez-2Qf-19@gated-at.bofh.it>
 <5r2nz-63n-233@gated-at.bofh.it>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Carsten Otto wrote:
> On Mon, Jan 02, 2006 at 08:01:08PM +0100, Andi Kleen wrote:
> 
>>Alternatively you can try with the appended patch. If that helps
>>then the chipset or the BIOS likely has some fundamental issue with >4GB.
> 
> 
> Based on the first few minutes of testing this works perfectly! Thanks a
> lot!
> 
> PS: Does it make sense to contact my shop and/or Abit and/or VIA
> regarding this problem? I don't want to pay money for broken hardware.

I suspect VIA may be the best place to complain to, it is most likely 
their breakage. I don't know how responsive they are to such things however.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

