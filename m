Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261718AbUDJT5G (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Apr 2004 15:57:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261803AbUDJT5G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Apr 2004 15:57:06 -0400
Received: from ns.clanhk.org ([69.93.101.154]:14517 "EHLO mail.clanhk.org")
	by vger.kernel.org with ESMTP id S261718AbUDJT5D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Apr 2004 15:57:03 -0400
Message-ID: <407851AB.2020409@clanhk.org>
Date: Sat, 10 Apr 2004 14:57:31 -0500
From: "J. Ryan Earl" <heretic@clanhk.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: Mohamed Aslan <mkernel@linuxmail.org>, linux-kernel@vger.kernel.org
Subject: Re: Rewrite Kernel
References: <20040407125406.209FC39834A@ws5-1.us4.outblaze.com> <4078280B.5080604@clanhk.org> <200404102021.36745.vda@port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200404102021.36745.vda@port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko wrote:

>>I doubt you would be capable of generating assembly that would be any
>>faster than gcc, and you would inherit all the accidental difficulties
>>that come with engineering software at a lower-level.
>>    
>>
>
>No, writing 'better than gcc' assembly is easy, gcc is far from stellar
>in this regard. But it's painfully slow and non-portable.
>  
>
How can "painfully slow and non-portable" be better?  You mean faster?

Doesn't change the fact that I doubt he could write faster assembly.  By 
the time he got done doing it in assembly, gcc 5 would probably be out 
generating much faster binaries, not to mention new major stable kernel 
revisions.
