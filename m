Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264917AbSJ3VYI>; Wed, 30 Oct 2002 16:24:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264922AbSJ3VYI>; Wed, 30 Oct 2002 16:24:08 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:16647 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S264917AbSJ3VYG>; Wed, 30 Oct 2002 16:24:06 -0500
Message-ID: <3DC04F39.1030709@namesys.com>
Date: Thu, 31 Oct 2002 00:29:29 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021016
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Oleg Drokin <green@namesys.com>
CC: Torrey Hoffman <thoffman@arnor.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Reiserfs List <reiserfs-list@namesys.com>
Subject: Re: [reiserfs-list] Mounting reiserfs with nonstandard journal size
 fails
References: <1035934581.1487.1409.camel@rivendell.arnor.net> <20021030093911.B5560@namesys.com>
In-Reply-To: <1035934581.1487.1409.camel@rivendell.arnor.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Drokin wrote:

>Hello!
>
>On Tue, Oct 29, 2002 at 03:36:20PM -0800, Torrey Hoffman wrote:
>  
>
>>I'm having trouble mounting a reiserfs filesystem created with a
>>nonstandard (smaller) journal size.  But if I use the default journal
>>size, it works fine.
>>    
>>
>
>Sure. Non-standard journal is only supported in 2.5 kernel for now.
>
>Bye,
>    Oleg
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
>  
>
That should be in the queue for the next pre1, yes?

-- 
Hans


