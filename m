Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265815AbTIJVqT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 17:46:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265816AbTIJVqT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 17:46:19 -0400
Received: from gadolinium.btinternet.com ([194.73.73.111]:10422 "EHLO
	gadolinium.btinternet.com") by vger.kernel.org with ESMTP
	id S265815AbTIJVqR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 17:46:17 -0400
Message-ID: <3F5F8D34.8020404@btopenworld.com>
Date: Wed, 10 Sep 2003 21:44:36 +0100
From: Subodh Shrivastava <subodh@btopenworld.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030901
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Patrick Mochel <mochel@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Power Management Update
References: <Pine.LNX.4.44.0309101407450.19541-100000@cherise>
In-Reply-To: <Pine.LNX.4.44.0309101407450.19541-100000@cherise>
X-Enigmail-Version: 0.76.4.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Patrick Mochel wrote:

>>Any chance of this  patch to be released against mm series? BTW i have 
>>tried suspend to disk (2.6.0-test4-mm6) with reiserfs filesystem
>>it worked fine and no fs corruption.
>>    
>>
>
>Good to hear. Thanks for testing. 
>  
>
Tried it with 2.6.0-test5-mm1.

When i tried suspend to disk with my usb modem (Alcatel Speedtouch) 
attached, system generated oops, couldn't get a dump on disk, will send 
the handwritten oops later. When i tried from X suspend to disk was 
successful but resume failed and system rebooted itself, did not get a 
chance to figure out what went wrong.

>Andrew picked up the last bunch of patches for the -mm series, so most of
>it already resides in that tree. With some luck, he'll do the same with
>
>the remaining patches. Otherwise, I can post an incremental patch on top 
>of the latest -mm kernel.
>
Please if you can

>
>
>	Pat
>
>
>  
>
Subodh

