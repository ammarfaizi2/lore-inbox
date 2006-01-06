Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932377AbWAFFxc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932377AbWAFFxc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 00:53:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932378AbWAFFxc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 00:53:32 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:15673 "EHLO
	pd4mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S932377AbWAFFxb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 00:53:31 -0500
Date: Thu, 05 Jan 2006 23:52:18 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: oops pauser.
In-reply-to: <5rAHn-5kc-9@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <43BE0592.3040200@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <5rvok-5Sr-1@gated-at.bofh.it> <5ryvR-2aN-5@gated-at.bofh.it>
 <5rAHn-5kc-9@gated-at.bofh.it>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> After an oops, we can't really rely on anything. What if the
> oops came from the console layer, or a framebuffer driver?

In this case, maybe it wouldn't work.. but I think it would be helpful a 
big majority of the time.

Surely there must be a way this could be done. After all, Windows seems 
to manage to fairly reliably switch the display into VGA 80x50 mode and 
put up the BSOD with error dump information with reasonably good 
reliability..

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

