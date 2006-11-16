Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031179AbWKPR5F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031179AbWKPR5F (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 12:57:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031152AbWKPR5F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 12:57:05 -0500
Received: from moutng.kundenserver.de ([212.227.126.187]:38142 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1031179AbWKPR5D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 12:57:03 -0500
Message-ID: <455CA665.4020701@webteks.co.uk>
Date: Thu, 16 Nov 2006 17:56:53 +0000
From: Chris Leadbeater <chris@webteks.co.uk>
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
MIME-Version: 1.0
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: Kernel.org server problems?
References: <455C79CE.2010800@webteks.co.uk> <200611161740.35628.s0348365@sms.ed.ac.uk>
In-Reply-To: <200611161740.35628.s0348365@sms.ed.ac.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:dca11bc32322bb1607c9ff439e70e0c8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alistair John Strachan wrote:
> On Thursday 16 November 2006 14:46, Chris wrote:
>   
>> Hi,
>>
>> Don't know if this is the correct place to bring this up but
>> /pub/linux/kernel/* seems to be unavailable on kernel.org via FTP. Both
>> my linux box and my work Windows box can connect to kernel.org, but
>> cding to the directory (I'm on the Windoze machine at the moment) gives:
>>
>> 230 Login successful.
>> ftp> cd pub
>> 250 Directory successfully changed.
>> ftp> cd linux
>> 250 Directory successfully changed.
>> ftp> cd kernel
>> 250 Directory successfully changed.
>> ftp> cd v2.6
>> (after about 30 seconds)
>> Connection closed by remote host.
>>
>> www.kernel.org via http seems to be REALLY slow as well.
>>     
>
> Git's also broken. This has become a major problem in recent months..
>
>   
Thanks for letting us know, the regional mirrors (for ftp.kernel.org, at 
least) seem to work perfectly though.
