Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261656AbTKBLuV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Nov 2003 06:50:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261659AbTKBLuV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Nov 2003 06:50:21 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:43425 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S261656AbTKBLuT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Nov 2003 06:50:19 -0500
Message-ID: <3FA4EF79.5060708@namesys.com>
Date: Sun, 02 Nov 2003 14:50:17 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Herbert Xu <herbert@gondor.apana.org.au>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0test9 Reiserfs boot time "buffer layer error at fs/buffer.c:431"
References: <20031029141931.6c4ebdb5.akpm@osdl.org> <E1AGCUJ-00016g-00@gondolin.me.apana.org.au> <20031101233354.1f566c80.akpm@osdl.org> <20031102092723.GA4964@gondor.apana.org.au>
In-Reply-To: <20031102092723.GA4964@gondor.apana.org.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Xu wrote:

>On Sat, Nov 01, 2003 at 11:33:54PM -0800, Andrew Morton wrote:
>  
>
>>aargh.  I thought Debian's 2.6 kernels were unmodified.  Are they carrying
>>any other changes?
>>    
>>
>
>Yes we are.  You can find the changes in
>
>http://http.us.debian.org/debian/pool/main/k/kernel-source-2.6.0-test9/
>
>  
>
>
Why are you guys modifying the official kernel?  Are you seeking 
advantage over the other distros or?  This was one of the nice things 
about debian, that it didn't have unofficial destabilizing stuff in the 
kernel like the other distros.

-- 
Hans


