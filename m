Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275347AbTHGNv5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 09:51:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275350AbTHGNv5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 09:51:57 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:40175 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S275347AbTHGNvy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 09:51:54 -0400
Message-ID: <3F325976.5090301@namesys.com>
Date: Thu, 07 Aug 2003 17:51:50 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030210
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-15?Q?Diego_Calleja_Garc=EDa?= <diegocg@teleline.es>
CC: Mike Fedyk <mfedyk@matchmail.com>, linux-kernel@vger.kernel.org,
       reiserfs-list@namesys.com
Subject: Re: Filesystem Tests
References: <3F306858.1040202@mrs.umn.edu>	<20030805224152.528f2244.akpm@osdl.org>	<3F310B6D.6010608@namesys.com>	<20030806183410.49edfa89.diegocg@teleline.es>	<20030806180427.GC21290@matchmail.com>	<20030806204514.00c783d8.diegocg@teleline.es>	<20030806190850.GF21290@matchmail.com> <20030806214023.74546b84.diegocg@teleline.es>
In-Reply-To: <20030806214023.74546b84.diegocg@teleline.es>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Diego Calleja García wrote:

>El Wed, 6 Aug 2003 12:08:50 -0700 Mike Fedyk <mfedyk@matchmail.com> escribió:
>
>  
>
>>But with servers, the larger your filesystem, the longer it will take to
>>fsck.  And that is bad for uptime.  Period.
>>    
>>
>
>Sure. But Han's "don't benchmark ext2 because it's not an option" isn't
>a valid stament, at least to me.
>
>I'm not saying ext2 is the best fs on earth, but i *really* think
>it's a real option, and as such, it must be benchmarked.
>
>
>  
>
Actually, I think it would be nice if Grant benchmarked it because it 
shows the overhead of ext3's journaling, but it should be noted that it 
is not a valid option for most servers.

-- 
Hans


