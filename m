Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262438AbVEMXNa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262438AbVEMXNa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 19:13:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262275AbVEMXM1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 19:12:27 -0400
Received: from warden2-p.diginsite.com ([209.195.52.120]:29152 "HELO
	warden2.diginsite.com") by vger.kernel.org with SMTP
	id S262394AbVEMXLp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 19:11:45 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Valdis.Kletnieks@vt.edu
Cc: Chris Friesen <cfriesen@nortel.com>, Bill Davidsen <davidsen@tmr.com>,
       linux-os@analogic.com, "Srinivas G." <srinivasg@esntechnologies.co.in>,
       linux-kernel-Mailing-list <linux-kernel@vger.kernel.org>
Date: Fri, 13 May 2005 16:10:17 -0700 (PDT)
X-X-Sender: dlang@dlang.diginsite.com
Subject: Re: Y2K-like bug to hit Linux computers! - Info of the day 
In-Reply-To: <200505132122.j4DLMRdU027493@turing-police.cc.vt.edu>
Message-ID: <Pine.LNX.4.62.0505131608450.26744@qynat.qvtvafvgr.pbz>
References: <4EE0CBA31942E547B99B3D4BFAB348114BED13@mail.esn.co.in>
 <200505131522.32403.vda@ilport.com.ua> <Pine.LNX.4.61.0505130825310.4428@chaos.analogic.com>
 <Pine.LNX.4.61.0505130837390.4781@chaos.analogic.com> <42850FC7.7010603@tmr.com>
 <200505132047.j4DKlcgV025923@turing-police.cc.vt.edu><428516F8.20100@nortel.com>
 <200505132122.j4DLMRdU027493@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 May 2005 Valdis.Kletnieks@vt.edu wrote:

> Date: Fri, 13 May 2005 17:22:27 -0400
> From: Valdis.Kletnieks@vt.edu
> To: Chris Friesen <cfriesen@nortel.com>
> Cc: Bill Davidsen <davidsen@tmr.com>, linux-os@analogic.com,
>     Srinivas G. <srinivasg@esntechnologies.co.in>,
>     linux-kernel-Mailing-list <linux-kernel@vger.kernel.org>
> Subject: Re: Y2K-like bug to hit Linux computers! - Info of the day 
> 
> On Fri, 13 May 2005 15:07:04 MDT, Chris Friesen said:
>
>> Because that's what the maximum negative number gives?
>
> Good, somebody's paying attention.   :)
>
> So what breaks if we change it to an 'unsigned int', and can we fix those
> issues before 2038, and will any of us here now *care* when an unsigned 32-bit
> overflows in 2106 or whenever it is? :)

all values that are currently prior to Jan 1 1970 would become post 2038 
dates

Guys, this isn't a new problem, it was discussed quite a bit in 1999 as 
well, as were a lot of potential solutions.

David Lang
-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare
