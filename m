Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262789AbSJ1AVE>; Sun, 27 Oct 2002 19:21:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262790AbSJ1AVE>; Sun, 27 Oct 2002 19:21:04 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:60938 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S262789AbSJ1AVC>; Sun, 27 Oct 2002 19:21:02 -0500
Message-ID: <3DBC8463.7040909@namesys.com>
Date: Mon, 28 Oct 2002 03:27:15 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2a) Gecko/20020910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: landley@trommello.org
CC: linux-kernel@vger.kernel.org,
       Reiserfs developers mail-list <Reiserfs-Dev@namesys.com>,
       reiserfs mailing list <reiserfs-list@namesys.com>,
       "Gryaznova E." <grev@namesys.botik.ru>
Subject: Re: The return of the return of crunch time (2.5 merge candidate
 list 1.6)
References: <200210251557.55202.landley@trommello.org> <3DBA0110.9020206@namesys.com> <200210270911.55926.landley@trommello.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Rob Landley wrote:

>
>  
>
>>Oh, and it has features too, not just performance....
>>    
>>
>
>I'm all for it.  I just can't put a patch on the list that doesn't exist yet.  
>(I suppose the entry could say "go bug Hans for a patch"... :)
>
>I'll think of something...
>
>  
>
>>Hans
>>    
>>
>
>Rob
>
>  
>

Thanks.  The guys will hopefully put a very beta patch (for developers 
only) on our download page sometime today (I am getting on an airplane 
to the USA, and leaving this to them), and a release appropriate for 
acceptance as an experimental filesystem will ship Halloween day.  

We want to make one last disk format change before it goes into the 
kernel.;-)  Yes, I know, plugins make disk format changes easy, but I 
still don't want there to be plugins that were only used for one week if 
I can avoid it, and our holding a final comprehensive disk format review 
on Friday found something better changed.

Read performance got worse, and write performance got better.  We'll 
have updated benchmarks on our website by the end of the day.

Hans


