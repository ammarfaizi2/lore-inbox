Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261937AbVBIVjP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261937AbVBIVjP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 16:39:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261938AbVBIVjP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 16:39:15 -0500
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:54932 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261937AbVBIVjD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 16:39:03 -0500
Message-ID: <420A82F4.7050600@acm.org>
Date: Wed, 09 Feb 2005 15:39:00 -0600
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bukie Mabayoje <bukiemab@gte.net>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Update to IPMI driver to support old DMI spec
References: <420A474B.2030608@acm.org> <420A826B.A4360D24@gte.net>
In-Reply-To: <420A826B.A4360D24@gte.net>
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bukie Mabayoje wrote:

>Corey Minyard wrote:
>
>  
>
>>BTW, I'm also working with the person who had the trouble with the I2C
>>non-blocking driver updates, but we haven't figured it out yet.
>>Hopefully soon.  (Though that has nothing to do with this patch.)
>>
>>Thanks,
>>
>>-Corey
>>
>>                                                  -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
>>The 1999 version of the DMI spec had a different configuration
>>than the newer versions for the IPMI configuration information.
>>    
>>
>
>Are you referring to the System Management BIOS Reference Specification  version 2.3.1 16 March 1999?
>  
>
Yes, that is correct.

-Corey

