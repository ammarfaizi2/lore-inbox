Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267118AbTAPOS5>; Thu, 16 Jan 2003 09:18:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267119AbTAPOS5>; Thu, 16 Jan 2003 09:18:57 -0500
Received: from ausmtp02.au.ibm.COM ([202.135.136.105]:6815 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP
	id <S267118AbTAPOS4>; Thu, 16 Jan 2003 09:18:56 -0500
Message-ID: <3E26C27A.7040107@ToughGuy.net>
Date: Thu, 16 Jan 2003 20:02:26 +0530
From: Linux Geek <bourne@ToughGuy.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: Maciej Soltysiak <solt@dns.toxicfilms.tv>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Tar'ing /proc ???
References: <Pine.LNX.3.95.1030116091326.4430A-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>
>the read. The result is a deadlock. Since `cat` or `cp` use
>small blocks and never have to call the kernel for additional
>resources, you can use them to get a snapshot. 
>  
>
Cool , Understood now ! . Thanks a lot for the time.

>  
>


