Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265890AbTBCDZH>; Sun, 2 Feb 2003 22:25:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265894AbTBCDZH>; Sun, 2 Feb 2003 22:25:07 -0500
Received: from atlrel9.hp.com ([156.153.255.214]:16290 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id <S265890AbTBCDZH>;
	Sun, 2 Feb 2003 22:25:07 -0500
Message-ID: <3E3DE0A9.4080106@india.hp.com>
Date: Mon, 03 Feb 2003 08:53:21 +0530
From: vishwas@india.hp.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020815
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: despinoz@isye.gatech.edu
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Kernel Oops
References: <200302022018.40902.despinoz@isye.gatech.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi, I am having problems with my kernel, it hangs up whenever I put some load 
> on it (example compile GCC), I'm using kernel 2.4.19 (attached is the config 
> file of the kernel) and the Oops that the kernel dump is this:

   This information is of no use. Pls. read lkml FAQ, abt how to report 
oops.
   Without the symbol information the numbers won't make any sense.

   read: linux/Documentation/oops-tracing.txt
   use:   linux/scripts/ksymoops & README.


-- 
regards,
vishwas

