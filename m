Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266460AbUJVRiQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266460AbUJVRiQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 13:38:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266721AbUJVRfg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 13:35:36 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:12217 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S266460AbUJVR03 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 13:26:29 -0400
Message-ID: <417942C0.7070301@namesys.com>
Date: Fri, 22 Oct 2004 10:26:24 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Reiserfs developers mail-list <Reiserfs-Dev@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: 2.6.9-mm1
References: <20041022032039.730eb226.akpm@osdl.org> <20041022103910.GB17526@infradead.org> <20041022035400.28131d76.akpm@osdl.org> <20041022110846.GA17866@infradead.org>
In-Reply-To: <20041022110846.GA17866@infradead.org>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:

>On Fri, Oct 22, 2004 at 03:54:00AM -0700, Andrew Morton wrote:
>  
>
>>>Your tree also has various rejected core changes for it still.
>>>      
>>>
>>Which were they?
>>    
>>
>
>reiser4-aliased-dir.patch
>reiser4-allow-drop_inode-implementation.patch
>reiser4-export-inode_lock.patch
>reiser4-kobject-umount-race.patch
>reiser4-unstatic-kswapd.patch
>
>
>I'm not completely sure what problems the following one could
>cause (or rather which problems of the scheme it's needed for
>it doesn't solve):
>
>reiser4-reget-page-mapping.patch
>
>  
>
zam and vs will respond tomorrow most likely, the day has ended in Moscow.
