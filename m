Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261885AbUCLBbM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 20:31:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261891AbUCLBbM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 20:31:12 -0500
Received: from smtp-out4.blueyonder.co.uk ([195.188.213.7]:1934 "EHLO
	smtp-out4.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S261885AbUCLBbJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 20:31:09 -0500
Message-ID: <405112DD.2020009@blueyonder.co.uk>
Date: Fri, 12 Mar 2004 01:31:09 +0000
From: Sid Boyce <sboyce@blueyonder.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Max Valdez <maxvalde@fis.unam.mx>
CC: linux-kernel@vger.kernel.org
Subject: Re: NVIDIA and 2.6.4?
References: <405082A2.5040304@blueyonder.co.uk> <200403111326.08055.maxvalde@fis.unam.mx>
In-Reply-To: <200403111326.08055.maxvalde@fis.unam.mx>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Mar 2004 01:31:08.0570 (UTC) FILETIME=[B1CBCFA0:01C407D1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Max Valdez wrote:

>That's weird:
>uname -a
>Linux garaged 2.6.4-rc2-mm1 #1 SMP Wed Mar 10 20:27:04 CST 2004 i686 Intel(R) 
>Pentium(R) 4 CPU 2.80GHz GenuineIntel GNU/Linux
>
>$ lsmod | grep nv
>nvidia               2075144  12
>
>
>Running KDE, using kdm, with nvidia module, no problem, I notice a slight 
>difference on fonts, but I dont know if it's my imagination.
>
>Been using nvidia modules for quite a few 2.6.x kernels, most of them mmX. 
>without problems
>
>Max
>  
>
Something strange happened, I shall try 2.6.4-mm1 shortly to see if it 
is still the same. I reckon though that I've suffered a filesystem 
corruption.
Regards
Sid.

-- 
Sid Boyce .... Hamradio G3VBV and keen Flyer
Linux Only Shop.

