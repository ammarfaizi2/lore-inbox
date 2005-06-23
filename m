Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262702AbVFWVVt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262702AbVFWVVt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 17:21:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262719AbVFWVVo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 17:21:44 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:29072 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S262732AbVFWVVF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 17:21:05 -0400
From: kernel-stuff@comcast.net (Parag Warudkar)
To: Andrew Haninger <ahaning@gmail.com>, Lee Revell <rlrevell@joe-job.com>
Cc: Jan Knutar <jk-lkml@sci.fi>,
       Alejandro Bonilla <abonilla@linuxwireless.org>,
       Yani Ioannou <yani.ioannou@gmail.com>,
       linux-thinkpad@linux-thinkpad.org, linux-kernel@vger.kernel.org
Subject: Re: [ltp] Re: IBM HDAPS Someone interested?
Date: Thu, 23 Jun 2005 21:20:50 +0000
Message-Id: <062320052120.27266.42BB27B2000B27F200006A82220075033000009A9B9CD3040A029D0A05@comcast.net>
X-Mailer: AT&T Message Center Version 1 (Dec 17 2004)
X-Authenticated-Sender: a2VybmVsLXN0dWZmQGNvbWNhc3QubmV0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Someone else mentioned SoftIce, which appears to cost more than 0USD,
> so I'm not going to get and try that right away. Are there any other
> low-cost methods of getting detailed information about the hardware as
> it's initialized and used?
> 
> -Andy

If you have 2 machines with FireWire ports - The kernel debugger that comes with Windows DDK is also very easy to use and quite useful for such things( at least that's what I found last time when I was having nausea from ndiswrapper :). 

Windows DDK is not downloadable for free  but it's very cheap to order a CD (~ 9USD IIRC).

Parag



