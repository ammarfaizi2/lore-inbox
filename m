Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271940AbTHDRDX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 13:03:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271943AbTHDRDX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 13:03:23 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:53910 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S271940AbTHDRDT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 13:03:19 -0400
Message-ID: <3F2E9145.5090407@namesys.com>
Date: Mon, 04 Aug 2003 21:00:53 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030210
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stephan von Krawczynski <skraw@ithnet.com>
CC: Jesse Pollard <jesse@cats-chateau.net>, aebr@win.tue.nl,
       linux-kernel@vger.kernel.org, god@namesys.com, Vitaly@Namesys.COM
Subject: Re: FS: hardlinks on directories
References: <20030804141548.5060b9db.skraw@ithnet.com>	<20030804134415.GA4454@win.tue.nl>	<20030804155604.2cdb96e7.skraw@ithnet.com>	<03080409334500.03650@tabby> <20030804170506.11426617.skraw@ithnet.com>
In-Reply-To: <20030804170506.11426617.skraw@ithnet.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephan von Krawczynski wrote:

>  
>
>>The KIS principle is the key. A graph is NOT simple to maintain.
>>    
>>
>
>This is true. But I am very willing to believe reiserfs is not simple either,
>still it is there ;-)
>
>Regards,
>Stephan
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
>  
>
If you want hard linked directories, send us a patch for v4.  Should be 
VERY easy to write.   If there is some reason it is not simple, let me 
know.  Discuss it with Vitaly though, it might affect fsck.

-- 
Hans


