Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264465AbUEXRTR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264465AbUEXRTR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 13:19:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264479AbUEXRTR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 13:19:17 -0400
Received: from 66-126-254-34.unm.net ([66.126.254.34]:25700 "EHLO
	mail.unminc.com") by vger.kernel.org with ESMTP id S264465AbUEXRTK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 13:19:10 -0400
Message-ID: <40B22E8D.6000901@unminc.com>
Date: Mon, 24 May 2004 10:19:09 -0700
From: Mark Beyer - Contractor <mbeyer@unminc.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6: future of UMSDOS?
References: <20040519184321.GB24287@fs.tum.de> <20040524145150.GQ1912@lug-owl.de>
In-Reply-To: <20040524145150.GQ1912@lug-owl.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan-Benedict Glaw wrote:

>On Wed, 2004-05-19 20:43:21 +0200, Adrian Bunk <bunk@fs.tum.de>
>wrote in message <20040519184321.GB24287@fs.tum.de>:
>  
>
>>Looking at the state of the UMSDOS code in 2.6 I'm currently wondering 
>>about it's future.
>>
>>Are there still potential users and people willing to work on getting it
>>working, or should it be removed from kernel 2.6?
>>    
>>
>
>In my early Linux days, UMSDOS was quite a neat thing to have for
>showing Linux to friends by placing a .zip'ed Linux installation on
>their MS-DOS machines.
>
>So for historic reasons, I think it would be nice to have UMSDOS around.
>  
>
There are still embedded systems that boot from a DOS file system. Yes, 
there are better methods but for backward compatibility I wouldn't like 
to see it removed.


