Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261159AbUCSUv3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 15:51:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261170AbUCSUtl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 15:49:41 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:11229 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S261168AbUCSUsv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 15:48:51 -0500
Message-ID: <405B5CB0.4090709@namesys.com>
Date: Fri, 19 Mar 2004 23:48:48 +0300
From: Hans Reiser <reiser@namesys.com>
Reply-To: reiser@namesys.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Mason <mason@suse.com>
CC: Peter Zaitsev <peter@mysql.com>, Jens Axboe <axboe@suse.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: True  fsync() in Linux (on IDE)
References: <1079572101.2748.711.camel@abyss.local>	 <20040318064757.GA1072@suse.de> <1079639060.3102.282.camel@abyss.local>	 <20040318194745.GA2314@suse.de>  <1079640699.11062.1.camel@watt.suse.com>	 <1079641026.2447.327.camel@abyss.local>	 <1079642001.11057.7.camel@watt.suse.com>	 <1079642801.2447.369.camel@abyss.local>	 <1079643740.11057.16.camel@watt.suse.com>	 <1079644190.2450.405.camel@abyss.local>	 <1079644743.11055.26.camel@watt.suse.com>  <405AA9D9.40109@namesys.com>	 <1079704347.11057.130.camel@watt.suse.com>	 <1079724411.2576.178.camel@abyss.local>	 <1079727833.11062.200.camel@watt.suse.com>  <405B58BB.1020208@namesys.com> <1079728706.11061.210.camel@watt.suse.com>
In-Reply-To: <1079728706.11061.210.camel@watt.suse.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Mason wrote:

>
>>
>>and I was imprecise, I should have asked, does fsync flush the disk 
>>cache regardless of what mount options are set or data/metadata touched 
>>in the 2.6 patches?
>>
>>    
>>
Forgive my relentlessness, is the answer to the above yes?

-- 
Hans

