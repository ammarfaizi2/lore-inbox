Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261632AbVGZE2Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261632AbVGZE2Z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 00:28:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261641AbVGZE2Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 00:28:25 -0400
Received: from hulk.hostingexpert.com ([69.57.134.39]:47840 "EHLO
	hulk.hostingexpert.com") by vger.kernel.org with ESMTP
	id S261632AbVGZE2Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 00:28:24 -0400
Message-ID: <42E5BBEF.6030608@m1k.net>
Date: Tue, 26 Jul 2005 00:28:31 -0400
From: Michael Krufky <mkrufky@m1k.net>
Reply-To: mkrufky@m1k.net
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: ncunningham@cyclades.com
CC: Mauro Carvalho Chehab <mchehab@brturbo.com.br>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Add missing tvaudio try_to_freeze.
References: <1121659791.13487.74.camel@localhost>	 <42E522B4.2080000@brturbo.com.br> <1122323285.4674.6.camel@localhost>
In-Reply-To: <1122323285.4674.6.camel@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hulk.hostingexpert.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - m1k.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nigel Cunningham wrote:

>On Tue, 2005-07-26 at 03:34, Mauro Carvalho Chehab wrote:
>  
>
>>Nigel Cunningham wrote:
>>    
>>
>>>The .c gives Gerd Knorr as the maintainer of this file, but no email
>>>address. The MAINTAINERS file doesn't have his name or make it clear who
>>>owns the file. I haven't therefore been able to cc the maintainer.
>>>      
>>>
>>I'm current maintainer of V4L. The patch was tested and it looks ok.
>>    
>>
>Thanks! Would you consider sending a patch to the maintainers file too?
>  
>
As you can see below, this has already been done.


[PATCH] V4L maintainer patch
author    Mauro Carvalho Chehab <mchehab@brturbo.com.br>
    Wed, 29 Jun 2005 03:45:20 +0000 (20:45 -0700)
committer    Linus Torvalds <torvalds@ppc970.osdl.org>
    Wed, 29 Jun 2005 04:20:36 +0000 (21:20 -0700)
commit    96b6aba08762f09e5dfa616854cb80ce054a7bf8
tree    788823ba3676e17b5f376ec6718dcf60662eaf87    tree
parent    200803dfe4ff772740d63db725ab2f1b185ccf92    commit | commitdiff
[PATCH] V4L maintainer patch

This patch updates maintainer info for BTTV and V4L.

Signed-off-by: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
Acked-by: Gerd Knorr <kraxel@bytesex.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>

-- 
Michael Krufky

