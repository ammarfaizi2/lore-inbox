Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263990AbUD2JmU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263990AbUD2JmU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 05:42:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264002AbUD2JmU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 05:42:20 -0400
Received: from jive.SoftHome.net ([66.54.152.27]:14029 "HELO jive.SoftHome.net")
	by vger.kernel.org with SMTP id S263990AbUD2JmR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 05:42:17 -0400
Message-ID: <4090CDF5.5030503@softhome.net>
Date: Thu, 29 Apr 2004 11:42:13 +0200
From: "Ihar 'Philips' Filipau" <filia@softhome.net>
User-Agent: Mozilla Thunderbird 0.5+ (Macintosh/20040414)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Neal Becker <ndbecker2@verizon.net>
CC: Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: State of linux checkpointing?
References: <1Q3nZ-2hv-3@gated-at.bofh.it> <1Q40J-2Mx-9@gated-at.bofh.it> <1Q6F8-53t-1@gated-at.bofh.it> <1Q8xl-6x2-17@gated-at.bofh.it>
In-Reply-To: <1Q8xl-6x2-17@gated-at.bofh.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neal Becker wrote:
> 
> I want checkpointing for:
> 
> 1) Protect against job interruption due to system crash, operator error,
> power loss, whatever
> 
> 2) Job mygration.  Even manual job mygration would be nice.
> 

   Several months ago some guys from Ukrain were announcing special 
patch for kernel which allows you to save task to file, and then later 
to load it from this file.
   Saving task to disk say every 5 seconds - is some sort of 
checkpointing, so later you will be able to go back in time :-)
   You might want to check l-k archives - I cannot recall correctly the 
name of this stuff.
