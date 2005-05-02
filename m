Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261455AbVEBQpy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261455AbVEBQpy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 12:45:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261440AbVEBQnv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 12:43:51 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:22154 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261455AbVEBQ3s
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 12:29:48 -0400
Message-ID: <42765546.5020600@tmr.com>
Date: Mon, 02 May 2005 12:28:54 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050319
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] remove BK documentation
References: <20050501233441.GC3592@stusta.de><20050501233441.GC3592@stusta.de> <20050501234331.GA9244@havoc.gtf.org>
In-Reply-To: <20050501234331.GA9244@havoc.gtf.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> On Mon, May 02, 2005 at 01:34:41AM +0200, Adrian Bunk wrote:
> 
>>There's no longer a reason to document the obsolete BK usage.
>>
>>Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> 
> If you are going to remove some documents, please at least have the
> common courtesy of CC'ing the author of the documents.
> 
> Speaking as the author of 90% of Documentation/BK-usage directory,
> I ACK this patch.
> 
> 	Jeff

This seems like a good place to thank Adrian for his cleaning fetish, 
which makes the kernel code and docs far less confusing, and Jeff, who 
put in most of the effort in documenting bk.

Documentation authors really should mention themselves in the 
introduction, docs aren't sexy and don't get your name in the news, but 
they are a vital part of making Linux usable.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
