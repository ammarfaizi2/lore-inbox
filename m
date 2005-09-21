Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750752AbVIUAKk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750752AbVIUAKk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 20:10:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750792AbVIUAKk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 20:10:40 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:46400 "EHLO
	pd5mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1750752AbVIUAKj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 20:10:39 -0400
Date: Tue, 20 Sep 2005 18:08:33 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: regarding kernel compilation
In-reply-to: <4OJNI-Rt-1@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <4330A481.9070606@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <4OJNI-Rt-1@gated-at.bofh.it>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gireesh Kumar wrote:
> Hi,
> I'd like to compile 2.4.20-6 kernel while running in 2.6 kernel. I tried
> to do so but there are redeclaration errors with /kernel/sched.c and
> /include/linux/sched.h. One it is FASTCALL and the other it is not.
> Can anyone help me to fix this?
> Thankyou,
> Gireesh.

What compiler? You probably need an older version of gcc to compile that 
kernel. gcc4 definitely will not work, 3.4 may have issues as well.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

