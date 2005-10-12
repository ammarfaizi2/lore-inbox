Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932380AbVJLAO6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932380AbVJLAO6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 20:14:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932381AbVJLAO6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 20:14:58 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:19744 "EHLO
	pd2mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S932380AbVJLAO5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 20:14:57 -0400
Date: Tue, 11 Oct 2005 18:18:11 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Dual Xeon Time skips with 2.6
In-reply-to: <4WyVi-5Xb-15@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <434C5643.3040706@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <4WbYJ-3Jt-17@gated-at.bofh.it> <4WbYJ-3Jt-15@gated-at.bofh.it>
 <4WyVi-5Xb-15@gated-at.bofh.it>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen wrote:
> This sounds familiar, although much larger than what I see, is it 
> possible for an Intel dual core CPU to do this as well? I sometimes see 
> very unintuitive timestamps on network stuff.

As far as I know that shouldn't happen.. though people thought the same 
thing with AMD dual core CPUs and it turns out the TSCs can apparently 
drift, I believe this was recently changed.

Can you verify whether or not this sort of time skew is actually happening?

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

