Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262796AbTLOATk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Dec 2003 19:19:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262795AbTLOATk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Dec 2003 19:19:40 -0500
Received: from adsl-67-114-19-185.dsl.pltn13.pacbell.net ([67.114.19.185]:26804
	"EHLO bastard") by vger.kernel.org with ESMTP id S262796AbTLOATh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Dec 2003 19:19:37 -0500
Message-ID: <3FDCFE17.5010309@tupshin.com>
Date: Sun, 14 Dec 2003 16:19:35 -0800
From: Tupshin Harper <tupshin@tupshin.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Larry McVoy <lm@bitmover.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RFC - tarball/patch server in BitKeeper
References: <20031214172156.GA16554@work.bitmover.com> <3FDCEF70.5040808@tupshin.com> <20031214234348.GA15850@work.bitmover.com>
In-Reply-To: <20031214234348.GA15850@work.bitmover.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy wrote:

>On Sun, Dec 14, 2003 at 03:17:04PM -0800, Tupshin Harper wrote:
>  
>
>>I'm sure many people will find this useful. Personally (and this is not 
>>intended as any sort of flame bait), I just want a way to get access to 
>>all raw bk changesets for a given project. 
>>    
>>
>
>I'm sure you do, I've read your postings on various SCM mailing lists.
>You'll have to get your test data elsewhere, sorry, we're not in the
>business of helping you develop a competing product.  Using BK to do
>that is a violation of the free use license and I'm sure you are aware
>of that.  
>  
>
Of course...that's the only reason why it's an issue.

>  
>
>>All existing methods of 
>>getting information out of a bk repository either involve running bk 
>>yourself, or getting incomplete information. You have argued 
>>(succesfully) that the CVS export doesn't lose very much information, 
>>but an argument can be made that any information loss is too much. After 
>>all, the information I am talking about is simply what was put into the 
>>system by the developers in the first place.
>>    
>>
>
>Nonsense!  It's the information put in there by BitKeeper.  The BK2CVS 
>export is an almost perfect mirror of what you'd get if the developers 
>were using CVS or Subversion or whatever.
>  
>
What are are effectively doing, then, is creating vendor lock-in based 
on file format...a very Microsoftian approach. You are encouraging 
developers to adopt your tool, but then telling them that if they ever 
want to adopt a different tool, then they will have to forego using some 
of the information that they created using your tool. So the decision of 
which tool to be used becomes based on pain of switching, and not based 
on technical merit. Hmmm.


-Tupshin
