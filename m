Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265998AbSLNWNT>; Sat, 14 Dec 2002 17:13:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266006AbSLNWNT>; Sat, 14 Dec 2002 17:13:19 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:22471 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S265998AbSLNWNS>; Sat, 14 Dec 2002 17:13:18 -0500
Message-ID: <3DFBAED2.1030905@namesys.com>
Date: Sun, 15 Dec 2002 01:21:06 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: Oleg Drokin <green@namesys.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BK][PATCH] ReiserFS CPU and memory bandwidth efficient large
 writes
References: <3DFA2D4F.3010301@namesys.com> <3DFA53DA.DE6788C1@digeo.com> <20021214162108.A3452@namesys.com> <3DFB7B9E.FC404B6B@digeo.com> <20021214222053.A10506@namesys.com> <3DFB904F.2ADDE2D4@digeo.com>
In-Reply-To: <3DFB904F.2ADDE2D4@digeo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>  
>
>>(and btw you have not even seen reiser4 stack usage ;) )
>>    
>>
>
>uh-oh.   We need to be very sparing indeed.
>
It is not appropriate to reduce functionality and twist the code so as 
to reduce the stack, in my opinion.  I suppose we'll get to that 
argument later though....

