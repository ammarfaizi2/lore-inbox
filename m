Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275317AbTHGMzq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 08:55:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275318AbTHGMzq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 08:55:46 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:44197 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S275317AbTHGMzp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 08:55:45 -0400
Message-ID: <3F324C4D.9000008@namesys.com>
Date: Thu, 07 Aug 2003 16:55:41 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030210
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-15?Q?Diego_Calleja_Garc=EDa?= <diegocg@teleline.es>
CC: linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: Filesystem Tests
References: <3F306858.1040202@mrs.umn.edu>	<20030805224152.528f2244.akpm@osdl.org>	<3F310B6D.6010608@namesys.com> <20030806183410.49edfa89.diegocg@teleline.es>
In-Reply-To: <20030806183410.49edfa89.diegocg@teleline.es>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Diego Calleja García wrote:

>El Wed, 06 Aug 2003 18:06:37 +0400 Hans Reiser <reiser@namesys.com> escribió:
>
>  
>
>>I don't think ext2 is a serious option for servers of the sort that 
>>Linux specializes in, which is probably why he didn't measure it.
>>    
>>
>
>Why?
>
Run fsck on a 1 terabyte array while a department waits for their server 
to come back up instead of having it back in 90 seconds and.....

disk speeds have increased linearly while their capacity has increased 
quadratically.

-- 
Hans


