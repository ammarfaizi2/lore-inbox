Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161485AbWATEJZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161485AbWATEJZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 23:09:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161486AbWATEJZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 23:09:25 -0500
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:63112 "EHLO
	out4.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S1161485AbWATEJY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 23:09:24 -0500
X-Sasl-enc: QyZkrN6j/7xd1md+PIXzW/jg71Zaafoq65x61cH9IV1h 1137730160
Message-ID: <43D0626A.2090802@fastmail.co.uk>
Date: Fri, 20 Jan 2006 12:09:14 +0800
From: Max Waterman <davidmaxwaterman+kernel@fastmail.co.uk>
User-Agent: Thunderbird 1.6a1 (Macintosh/20060117)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: io performance...
References: <5vx8f-1Al-21@gated-at.bofh.it> <5wbRY-3cF-3@gated-at.bofh.it>	 <5wdKh-5wF-15@gated-at.bofh.it> <43CEF263.9060102@shaw.ca>	 <43CF90C6.8050505@fastmail.co.uk> <1137679698.8471.30.camel@localhost.localdomain>
In-Reply-To: <1137679698.8471.30.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Iau, 2006-01-19 at 21:14 +0800, Max Waterman wrote:
>> So, if I have my raid controller set to use write-back, it *is* caching 
>> the writes, and so this *is* a bad thing, right?
> 
> Depends on your raid controller. If it is battery backed it may well all
> be fine.

Eh? Why?

I'm not sure what difference it makes if the controller is battery 
backed or not; if the drives are gone, then the card has nothing to 
write to...will it make the writes when the power comes back on?

Max.
