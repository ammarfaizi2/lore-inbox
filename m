Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261659AbTKBLys (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Nov 2003 06:54:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261660AbTKBLys
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Nov 2003 06:54:48 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:46753 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S261659AbTKBLyq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Nov 2003 06:54:46 -0500
Message-ID: <3FA4F085.4080002@namesys.com>
Date: Sun, 02 Nov 2003 14:54:45 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Herbert Xu <herbert@gondor.apana.org.au>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0test9 Reiserfs boot time "buffer layer error at fs/buffer.c:431"
References: <20031029141931.6c4ebdb5.akpm@osdl.org> <E1AGCUJ-00016g-00@gondolin.me.apana.org.au> <20031101233354.1f566c80.akpm@osdl.org> <20031102092723.GA4964@gondor.apana.org.au> <20031102014011.09001c81.akpm@osdl.org> <20031102095441.GA5248@gondor.apana.org.au>
In-Reply-To: <20031102095441.GA5248@gondor.apana.org.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Xu wrote:

>On Sun, Nov 02, 2003 at 01:40:11AM -0800, Andrew Morton wrote:
>  
>
>>Where are the separated patches?
>>    
>>
>
>There are no separate patches.  You can check the README.Debian file
>for the details of the changes.
>
>  
>
>>That's 170k of stuff you're sitting on.  Is there any plan to get it synced
>>up?
>>    
>>
>
>I submit them as they come in.  The bulk of the size comes from the
>making IDE modules work which isn't right yet.
>
>The rest of them which are suitable for general consumption have
>been submitted previously.  I will resend them later.
>  
>
Why in the world do you guys do this?  Andrew and Marcelo do a good job, 
and I haven't heard much complaint about patches being ignored by them, 
so follow the leader.  If you have patches you need, send them to them.

-- 
Hans


