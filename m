Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262616AbVDAEiZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262616AbVDAEiZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 23:38:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262617AbVDAEiY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 23:38:24 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:65394 "EHLO
	pd4mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S262616AbVDAEiV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 23:38:21 -0500
Date: Thu, 31 Mar 2005 22:37:44 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: AMD64 Machine hardlocks when using memset
In-reply-to: <3O99L-40N-9@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <424CD018.5000005@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <3NTHD-8ih-1@gated-at.bofh.it> <3O99L-40N-9@gated-at.bofh.it>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stelian Pop wrote:
> Just a thought: does deactivating cpufreq change anything ?
> 
> I haven't tested yet your program, but on my Asus K8NE-Deluxe very
> strange things happen if cpufreq/powernow is activated *and* 
> the cpu frequency is changed...

Didn't change anything for me, I tried deactivating cpufreq, still 
crashes when I run that test program.

This is getting pretty ridiculous.. I've tried memory timings down to 
the slowest possible, ran Memtest86 for 4 passes with no errors, and 
it's been stable in Windows for a few months now. Still something is 
blowing up in Linux with this test though..

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

