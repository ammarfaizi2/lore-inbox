Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964946AbWDHOFn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964946AbWDHOFn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Apr 2006 10:05:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751416AbWDHOFn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Apr 2006 10:05:43 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:20815 "EHLO
	pd5mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1751390AbWDHOFm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Apr 2006 10:05:42 -0400
Date: Sat, 08 Apr 2006 08:05:41 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Black box flight recorder for Linux
In-reply-to: <5ZlZk-7VF-13@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andi Kleen <ak@suse.de>
Message-id: <4437C335.30107@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <5ZjEd-4ym-37@gated-at.bofh.it> <5ZlZk-7VF-13@gated-at.bofh.it>
User-Agent: Thunderbird 1.5 (Windows/20051201)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> James Courtier-Dutton <James@superbug.co.uk> writes:
>> Now, the question I have is, if I write values to RAM, do any of those
>> values survive a reset?
> 
> They don't generally.
> 
> Some people used to write the oopses into video memory, but that
> is not portable.

I wouldn't think most BIOSes these days would bother to clear system RAM 
on a reboot. Certainly Microsoft was encouraging vendors not to do this 
because it slowed down system boot time.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

