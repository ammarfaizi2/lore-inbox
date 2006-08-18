Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751337AbWHRKES@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751337AbWHRKES (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 06:04:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751338AbWHRKER
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 06:04:17 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:388 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S1751337AbWHRKEQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 06:04:16 -0400
Message-ID: <44E58FDC.6030007@aitel.hist.no>
Date: Fri, 18 Aug 2006 12:01:00 +0200
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Thunderbird 1.5.0.4 (X11/20060713)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: john stultz <johnstul@us.ibm.com>, Helge Hafting <helgehaf@aitel.hist.no>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc4-mm1 - time moving at 3x speed!
References: <20060813012454.f1d52189.akpm@osdl.org> <200608181134.02427.ak@suse.de> <44E588AB.3050900@aitel.hist.no> <200608181255.46999.ak@suse.de>
In-Reply-To: <200608181255.46999.ak@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
>> I have narrowed it down.  2.6.18-rc4 does not have the 3x time
>> problem,  while mm1 have it.  mm1 without the hotfix jiffies
>> patch is just as bad.
>>     
>
> Can you narrow it down to a specific patch in -mm? 
>   
How do I do that?  Is -mm available through git somehow,
or is there some other clever way?

Helge Hafting
