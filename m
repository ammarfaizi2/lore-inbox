Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751304AbVLEBJx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751304AbVLEBJx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Dec 2005 20:09:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751314AbVLEBJx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Dec 2005 20:09:53 -0500
Received: from c-67-177-35-222.hsd1.ut.comcast.net ([67.177.35.222]:62094 "EHLO
	vger.utah-nac.org") by vger.kernel.org with ESMTP id S1751304AbVLEBJx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Dec 2005 20:09:53 -0500
Message-ID: <43938D40.7040804@wolfmountaingroup.com>
Date: Sun, 04 Dec 2005 17:43:44 -0700
From: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bernd Petrovitsch <bernd@firmix.at>
Cc: Matthias Andree <matthias.andree@gmx.de>, linux-kernel@vger.kernel.org
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
References: <20051203135608.GJ31395@stusta.de>	 <1133620598.22170.14.camel@laptopd505.fenrus.org>	 <20051203152339.GK31395@stusta.de>	 <20051203162755.GA31405@merlin.emma.line.org>	 <1133630556.22170.26.camel@laptopd505.fenrus.org>	 <20051203230520.GJ25722@merlin.emma.line.org>	 <43923DD9.8020301@wolfmountaingroup.com> <1133732132.3317.32.camel@gimli.at.home>
In-Reply-To: <1133732132.3317.32.camel@gimli.at.home>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernd Petrovitsch wrote:

>On Sat, 2005-12-03 at 17:52 -0700, Jeff V. Merkey wrote:
>[...]
>  
>
>>of this code. I have apps written for Windows in 1990 and 1998 that 
>>    
>>
>                       ^^^^
>  
>
>>still run on Windows XP today. Linux has no such concept of
>>    
>>
>
>But this not even holds for nearly all apps.
>
>  
>
>>backwards compatiblity. Every company who has embraced it outside of 
>>    
>>
>
>The same holds (probably) for Linux apps (given that your kernel can
>start a.out). And AFAIBT by Win* driver developers even in the Win*
>world you have to change your driver because of a new Win* version now
>and then.
>
>	Bernd
>  
>
No.  BIND was has been busted between 2.4 and 2.6.  Not to mention the 
whole libc -> glib switchover.
It's hilarious that BSD had to create a Linux app compat lib, and the 
RedHat shipped compat libs for 3 releases
as well.   Not even close.  Windows has won.  M$ has won.  Linux lost 
the desktop wars and will soon loose
the server wars as well.   The reason - infighting and lack of backwards 
compatibility.  Binary only module
breakage kernel to kernel will continue. 

Jeff


