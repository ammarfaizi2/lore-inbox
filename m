Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261783AbVCWSXM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261783AbVCWSXM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 13:23:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262789AbVCWSXL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 13:23:11 -0500
Received: from mailin.zma.compaq.com ([161.114.64.102]:57102 "EHLO
	zmamail02.zma.compaq.com") by vger.kernel.org with ESMTP
	id S261783AbVCWSXI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 13:23:08 -0500
Message-ID: <4241B407.4070700@hp.com>
Date: Wed, 23 Mar 2005 13:23:03 -0500
From: Mark Seger <Mark.Seger@hp.com>
Organization: Consulting and Architecture
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Patch for inconsistent recording of block device statistics
References: <42409313.1010308@hp.com> <20050323091916.GO24105@suse.de> <42417FE3.2090506@hp.com> <20050323155150.GE16149@suse.de>
In-Reply-To: <20050323155150.GE16149@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>>re: your patch - I did try it on both an Operton and Xeon box.  It 
>>worked find on the Opeteron and reported 0 for all the sectors on the 
>>Xeon.  If nothing immediately jumps to your mind could it have been 
>>something I did wrong?  I'll try another build after I send this along, 
>>but I don't see how that will help as I did the first one from a brand 
>>new source kit.
>>    
>>
>
>Sounds very strange, it is generic code so should work for all.
>Different storage?
>  
>
Works fine now.  Obviously I screwed up something and just wanted to let 
you know it was cockpit error on my end.
Is your plan to move this into some future kernel?  Do you need anything 
more from me at this point?

-mark

