Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264208AbTFPTzB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 15:55:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264218AbTFPTzB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 15:55:01 -0400
Received: from wmail.atlantic.net ([209.208.0.84]:42369 "HELO
	wmail.atlantic.net") by vger.kernel.org with SMTP id S264208AbTFPTy6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 15:54:58 -0400
Message-ID: <3EEE272A.2040208@techsource.com>
Date: Mon, 16 Jun 2003 16:23:06 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Aschwin Marsman <a.marsman@aYniK.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Coding technique question
References: <Pine.LNX.4.44.0306162202480.1924-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for pointing this out to me.  It's very interesting reading.


Aschwin Marsman wrote:
> On Mon, 16 Jun 2003, Timothy Miller wrote:
> 
> 
>>I believe I've seen this sort of thing done in the kernel:
>>
>>do {
>>     ....
>>     code
>>     ....
>>} while (0);
>>
>>
>>What I was wondering is how this is any different from:
>>
>>{
>>     ....
>>     code
>>     ....
>>}
> 
> 
> See the Kernel Newbies FAQ at http://kernelnewbies.org/faq/
> Q: "Why do a lot of #defines in the kernel use do { ... } while(0)? "
>  
> Best regards,
>  
> Aschwin Marsman
>  
> --
> aYniK Software Solutions         all You need is Knowledge
> Bedrijvenpark Twente 305         NL-7602 KL Almelo - the Netherlands
> P.O. box 134                     NL-7600 AC Almelo - the Netherlands
> a.marsman@aYniK.com              http://www.aYniK.com
> 
> 
> 


