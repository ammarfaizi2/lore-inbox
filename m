Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263631AbTGAUUg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 16:20:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263632AbTGAUUg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 16:20:36 -0400
Received: from mail3.netbeat.de ([62.208.140.20]:25515 "HELO mail3.netbeat.de")
	by vger.kernel.org with SMTP id S263631AbTGAUUf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 16:20:35 -0400
Message-ID: <3F01F052.8070307@gmx.de>
Date: Tue, 01 Jul 2003 22:34:26 +0200
From: =?UTF-8?B?Q29ybmVsaXVzIEvDtmxiZWw=?= <cornelius.koelbel@gmx.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.4) Gecko/20030601
X-Accept-Language: de-de, en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Fwd: Bug in Kernel 2.4.20-8]
References: <3F0139D5.1080602@gmx.de> <1057085646.18955.19.camel@dhcp22.swansea.linux.org.uk>
In-Reply-To: <1057085646.18955.19.camel@dhcp22.swansea.linux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>On Maw, 2003-07-01 at 08:35, Cornelius Kölbel wrote:
>  
>
>>I am using Kernel 2.4.20. I admit, it is the kernel of RedHat 9.
>>I hope this is not, because RedHat did so much changes to the Kernel
>>    
>>
>
>Always hard to tell. It is worth filing Red Hat kernel bugs in
>https://bugzilla.redhat.com/bugzilla and picking up current errata
>kernels if there are newer ones
>
>  
>
>>I was just typing a mail, when the caps lock light and the scroll lock light went on.
>>Nothing happend anymore. No mouse, no keyboard.
>>I resetted the computer.
>>    
>>
>
>This is a panic - the machine got itself into a state that could not
>continue. The flashing lights are giving data in morse (useful for those
>truely desperate debugging situations only 8))
>
>  
>
After having watched some other problems, I guess it is due to a bad 
memory module. (Can this be?)
I removed this module and since then, I had no proplems anymore.

