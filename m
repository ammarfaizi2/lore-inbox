Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261966AbTCQWKv>; Mon, 17 Mar 2003 17:10:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261967AbTCQWKu>; Mon, 17 Mar 2003 17:10:50 -0500
Received: from s383.jpl.nasa.gov ([137.78.170.215]:54690 "EHLO
	s383.jpl.nasa.gov") by vger.kernel.org with ESMTP
	id <S261966AbTCQWKt>; Mon, 17 Mar 2003 17:10:49 -0500
Message-ID: <3E764A72.1070903@jpl.nasa.gov>
Date: Mon, 17 Mar 2003 14:21:38 -0800
From: Bryan Whitehead <driver@jpl.nasa.gov>
Organization: Jet Propulsion Laboratory
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en, zh, zh-cn, zh-hk, zh
MIME-Version: 1.0
To: Bernd Eckenfels <ecki@calista.eckenfels.6bone.ka-ip.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: FileSystem XFS vs RiserFS vs ext3
References: <E18uq2v-0004P7-00@calista.inka.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernd Eckenfels wrote:
> In article <3E7556C2.7030000@thizgroup.com> you wrote:
> 
>>Hi all I get basic understanding of the functions and different between
>>XFS, RiserFS and ext3. But in high volumn read write enviornment (database,
>>NFS email server etc), which will provide better preformance?
> 
> 
> NFS is a bit tricky. Reiser used to be broken on it, and at least from large
> XFS NFS Servers I know that they tend to be unstable, still.

I've never had problems with XFS+NFS on any of my servers... Is there a 
link or something you can provide?

Thanks.



-- 
Bryan Whitehead
SysAdmin - JPL - Interferometry Systems and Technology
Phone: 818 354 2903
driver@jpl.nasa.gov

