Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268164AbUH0INm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268164AbUH0INm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 04:13:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268162AbUH0INa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 04:13:30 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:40664 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S267934AbUH0IMq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 04:12:46 -0400
Message-ID: <412EECFC.5050804@namesys.com>
Date: Fri, 27 Aug 2004 01:12:44 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@lst.de>
CC: Nikita Danilov <nikita@clusterfs.com>,
       Dmitry Baryshkov <mitya@school.ioffe.ru>, Andrew Morton <akpm@osdl.org>,
       linux-fsdevel@vger.kernel.org,
       linux-kernel <linux-kernel@vger.kernel.org>, flx@namesys.com,
       torvalds@osdl.org, reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
References: <20040825152805.45a1ce64.akpm@osdl.org> <412D9FE6.9050307@namesys.com> <20040826014542.4bfe7cc3.akpm@osdl.org> <412DAC59.4010508@namesys.com> <1093548414.5678.74.camel@krustophenia.net> <20040826203017.GA14361@school.ioffe.ru> <1093552692.13881.43.camel@leto.cs.pocnet.net> <16686.22336.829096.678178@thebsh.namesys.com> <1093556818.13881.75.camel@leto.cs.pocnet.net> <16686.24120.761440.969273@thebsh.namesys.com> <20040826220546.GA12401@lst.de>
In-Reply-To: <20040826220546.GA12401@lst.de>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:

>On Fri, Aug 27, 2004 at 02:03:36AM +0400, Nikita Danilov wrote:
>  
>
>> > What about fs/reiser4/plugin/node/ and fs/reiser4/plugin/disk_format/?
>> > 
>> > Of course you can implement another filesystem inside the plugins but
>> > they wouldn't use fs/reiser4/*.c, so this would be rather stupid. Right?
>> > 
>>
>>That was the message of my message.
>>    
>>
>
>And I think Christophe and me already agreed in this thread that these
>upper level plugin facility should go away before merge anyway.  We made
>the mistake of not requesting removel of that one for XFS and now SGI
>blocks it's removal.
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
>  
>
Your arrogance is misplaced for a man who has never done a significant 
piece of research.

Christoph, we are doing work, you are in the way, get out of the way.

Hans
