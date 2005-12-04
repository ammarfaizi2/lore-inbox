Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751307AbVLDENZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751307AbVLDENZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 23:13:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751312AbVLDENZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 23:13:25 -0500
Received: from hulk.vianw.pt ([195.22.31.43]:62124 "EHLO hulk.vianw.pt")
	by vger.kernel.org with ESMTP id S1751307AbVLDENY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 23:13:24 -0500
Message-ID: <43926CC8.2030902@esoterica.pt>
Date: Sun, 04 Dec 2005 04:12:56 +0000
From: Paulo da Silva <psdasilva@esoterica.pt>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Dike <jdike@addtoit.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Cannot run linux 2.6.14.3 UML on a x86_64
References: <43924B2C.9000300@esoterica.pt> <20051204043205.GA15425@ccure.user-mode-linux.org>
In-Reply-To: <20051204043205.GA15425@ccure.user-mode-linux.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Dike wrote:

>On Sun, Dec 04, 2005 at 01:49:32AM +0000, Paulo da Silva wrote:
>  
>
>>I got the following boot output from
>>uml linux 2.6.14.3 from a x86_64.
>>    
>>
>
>Are you using a 32 or 64-bit filesystem?
>  
>
I did a mke2fs running on a 64 bits (x86_64) system.
Is there a way to specify that a filesystem is for 64 bits?

>And why it is running in tt mode?  CONFIG_MODE_SKAS is disabled?
>
>				Jeff
>  
>
I am using linux for 64 bits since a couple of days before.
I did not patch the host kernel with skas yet.
Besides performance, is there any other reason to use it?

