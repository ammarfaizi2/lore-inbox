Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261817AbVCVUUJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261817AbVCVUUJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 15:20:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261759AbVCVUUJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 15:20:09 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:40323 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S261817AbVCVUPN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 15:15:13 -0500
Message-ID: <42407CCA.6020307@namesys.com>
Date: Tue, 22 Mar 2005 12:15:06 -0800
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       reiserfs-dev@namesys.com
Subject: Re: 2.6.12-rc1-mm1: REISER4_FS <-> 4KSTACKS
References: <20050321025159.1cabd62e.akpm@osdl.org> <20050322171340.GE1948@stusta.de> <42405AD6.9010804@namesys.com> <20050322192122.GG1948@stusta.de>
In-Reply-To: <20050322192122.GG1948@stusta.de>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:

>On Tue, Mar 22, 2005 at 09:50:14AM -0800, Hans Reiser wrote:
>
>  
>
>>All of my technical arguments on this topic were nicely obliterated by
>>Andrew.  The only real reason remaining (that I know of) is that I want
>>to first eliminate all things which are a barrier to inclusion before
>>dealing with this because it requires man hours to fix it.  If you want
>>to send us a cleanup patch that fixes it, I would be grateful for your
>>time donatioin.
>>    
>>
>
>My plan is to send a patch to Andrew that unconditionally enables 
>4KSTACKS for shaking out the last bugs before possibly removing
>8 kB stacks completely.
>
>I don't know whether this is barrier to inclusion, but this will make 
>reiser4 unavailable on i386...
>
>  
>
>>Hans
>>    
>>
>
>cu
>Adrian
>
>  
>
Sigh.   Could you wait a few weeks until we have done all the other
things, and then I can have Vladimir work with you on it?
