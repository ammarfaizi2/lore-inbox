Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751004AbWGVTdj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751004AbWGVTdj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jul 2006 15:33:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751006AbWGVTdj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jul 2006 15:33:39 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:25481 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S1750907AbWGVTdi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jul 2006 15:33:38 -0400
Message-ID: <44C26F65.4000103@namesys.com>
Date: Sat, 22 Jul 2006 12:33:09 -0600
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Theodore Tso <tytso@mit.edu>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: the " 'official' point of view" expressed by kernelnewbies.org
 regarding reiser4 inclusion
References: <44C12F0A.1010008@namesys.com> <20060722130219.GB7321@thunk.org>
In-Reply-To: <20060722130219.GB7321@thunk.org>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Tso wrote:

>
>Actually, the first bits
>
yes, the first bits....   other people send in completed filesystems....

> that we plan to merge
>
I don't actually think that your merge approach is the wrong one, I
think that it being exclusive to you is what is wrong.

>
>  
>
>>Consider what happened with XFS as the article writer mentions.  I met
>>the original XFS team, led by two very senior developers (Jim Grey, and
>>another fellow whose name I am blanking on, forgive me, I learned much
>>from him in just a few conversations).  
>>    
>>
>
>I believe you are referring to Jim Mostek
>
Ah, Jim Mostek and Jim Gray.  (Steve Lord was not a senior guy back
then, and he is still with SGI last I heard....  I actually don't know
Steve very well, hmm, maybe some future conference....)  Thanks.

>That's hardly what happened.  SGI went through layoffs, and they were
>hit.  See:  http://slashdot.org/articles/01/05/26/0743254.shtml
>  
>
As the other poster mentioned, they went off to startups, and did not
become part of our community.  How much of that was because their
contributions were more hassled than welcomed, I cannot say with
certainty, I can only say that they were discouraged by the difficulty
of getting their stuff in, and this was not as it should have been. 
They were more knowledgeable than we were on the topics they spoke on,
and this was not recognized and acknowledged.

Outsiders are not respected by the kernel community.  This means we miss
a lot.

>  
>
>>A reasonable approach would be to say that any
>>filesystem marked as experimental can be dropped at any time, so if you
>>aren't able to tar and untar the partition it is on when a new kernel
>>comes out, you should not use experimental filesystems.  Then most
>>distros will not make the experimental FS visible to users who don't
>>press three buttons acknowledging that they were warned....  Linspire's
>>view is pretty simple, they need to know that Reiser4 will be accepted
>>BEFORE they make their distro depend on it.  
>>    
>>
>
>You do realize these two statements are completely contradictory,
>don't you? 
>
No, because distros would wait until it is not experimental before
giving it to their users by default, in my proposed release model.  lkml
is populated with people FAR more suited to experimenting with
experimental filesystems than typical distro customer lists are.  It is
commercial and political reasons that motivate distros being the first
with patches not tried yet by lkml, not the interests of the users.

Now, for other patches these commercial and political reasons may need
to be catered to as the price of getting the Redhats of the world to
fund kernel development, but that logic does not apply to Reiser4's
particulars.

Hans
