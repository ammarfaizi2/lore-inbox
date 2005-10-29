Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750768AbVJ2HfU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750768AbVJ2HfU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 03:35:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751377AbVJ2HfU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 03:35:20 -0400
Received: from omta04ps.mx.bigpond.com ([144.140.83.156]:8190 "EHLO
	omta04ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1750768AbVJ2HfU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 03:35:20 -0400
Message-ID: <43632635.7080604@bigpond.net.au>
Date: Sat, 29 Oct 2005 17:35:17 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthew Wilcox <matthew@wil.cx>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: sym53c8xx_2 is flooding my syslog ...
References: <430FD71C.6050704@bigpond.net.au>
In-Reply-To: <430FD71C.6050704@bigpond.net.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta04ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Sat, 29 Oct 2005 07:35:17 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Williams wrote:
> ... with the following message:
> 
> Aug 21 04:53:28 mudlark kernel: ..<6>sd 0:0:6:0: phase change 6-7 
> 9@01ab97a0 resid=7.
> 
> every 2 seconds.  Since the problem being reported seems to have no 
> effect on the operation of the scsi devices is it really necessary to 
> report it so often?
> 

This problem is still occurring on 2.6.14.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
