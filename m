Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936429AbWLALMi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936429AbWLALMi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 06:12:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936432AbWLALMi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 06:12:38 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:19429 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S936429AbWLALMh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 06:12:37 -0500
Message-ID: <45700E10.2080902@fr.ibm.com>
Date: Fri, 01 Dec 2006 12:12:16 +0100
From: Cedric Le Goater <clg@fr.ibm.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Kirill Korotaev <dev@sw.ru>
CC: Herbert Poetzl <herbert@13thfloor.at>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       Linux Containers <containers@lists.osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: Linux 2.6.19 VServer 2.1.x
References: <20061201022904.GP2826@MAIL.13thfloor.at> <457004DF.7030100@sw.ru>
In-Reply-To: <457004DF.7030100@sw.ru>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Great ! 

I'm dreaming that the next patchsets will not require as much
debate. nah, stop dreaming Cedric :)

Thanks to Andrew and Linus who made it happen.

C.

Kirill Korotaev wrote:

> OpenVZ has been using them for more than a month already ;-)
> 
> Kirill
> 
>> Ladies and Gentlemen!
>>
>> here is the first Linux-VServer version (testing)
>> with support for the *spaces (uts, ipc and vfs)
>> introduced in 2.6.19 ...
>>
>> http://vserver.13thfloor.at/Experimental/patch-2.6.19-vs2.1.x-t1.diff
>>
>> it might not be as perfect as the kernel itself *G*
>> but it does work fine here, and with recent tools
>> most virtualization features work as expected
>>
>> please if you do testing, report issues or comments
>> to the Linux-VServer mailing list or to me directly
>> (at least CC would be fine) and do not bother the
>> nice kernel folks ...
>>
>> enjoy,
>> Herbert
