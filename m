Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262061AbVGFE7m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262061AbVGFE7m (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 00:59:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262050AbVGFE7m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 00:59:42 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:4267 "EHLO
	pd3mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S262061AbVGFCs0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 22:48:26 -0400
Date: Tue, 05 Jul 2005 20:47:58 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Thread_Id
In-reply-to: <4mUJ1-5ZG-23@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <42CB465E.6080104@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <4mfcK-UT-25@gated-at.bofh.it> <4mUJ1-5ZG-23@gated-at.bofh.it>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

RVK wrote:
> Can anyone suggest me how to get the threadId using 2.6.x kernels. 
> pthread_self() does not work and returns some -ve integer.

What do you mean, negative integer? It's not an integer, it's a 
pthread_t, you're not even supposed to look at it..

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

