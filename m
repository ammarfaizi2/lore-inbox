Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267866AbUHZIus@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267866AbUHZIus (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 04:50:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267839AbUHZIt4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 04:49:56 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:22921 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S267866AbUHZIn6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 04:43:58 -0400
Message-ID: <412DA2CF.2030204@namesys.com>
Date: Thu, 26 Aug 2004 01:43:59 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@lst.de>
CC: Alex Zarochentsev <zam@namesys.com>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       Linus Torvalds <torvalds@osdl.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
References: <20040824202521.GA26705@lst.de> <412CEE38.1080707@namesys.com> <20040825200859.GA16345@lst.de> <20040825203516.GB4688@backtop.namesys.com> <20040825205149.GA17654@lst.de>
In-Reply-To: <20040825205149.GA17654@lst.de>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:

>On Thu, Aug 26, 2004 at 12:35:17AM +0400, Alex Zarochentsev wrote:
>  
>
>>Reiser4 may have a mount option for whoose who like or have to use traditional
>>O_DIRECTORY semantics.  There would be no /metas under non-directories, if user
>>wants that.
>>    
>>
>
>Again, O_DIRECTORY was added to solve a real-world race, not just for
>the sake of it. 
>
Can you supply more details and we will try to reply concretely?  Thanks.

> If you really want to add that option I'll research the
>CAN number for you so you can named it after that - or just call it -o
>insecure directly.
>
>
>
>  
>

