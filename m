Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282781AbRK0D5N>; Mon, 26 Nov 2001 22:57:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282780AbRK0D5D>; Mon, 26 Nov 2001 22:57:03 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:995 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S282779AbRK0D4o>; Mon, 26 Nov 2001 22:56:44 -0500
Message-ID: <3C030EFB.8060001@redhat.com>
Date: Mon, 26 Nov 2001 22:56:43 -0500
From: Doug Ledford <dledford@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6+) Gecko/20011121
X-Accept-Language: en-us
MIME-Version: 1.0
To: Sean Elble <S_Elble@yahoo.com>
CC: "Nathan G. Grennan" <ngrennan@okcforum.org>, linux-kernel@vger.kernel.org
Subject: Re: Unresponiveness of 2.4.16
In-Reply-To: <1006812135.1420.0.camel@cygnusx-1.okcforum.org> <01b501c176f6$8bac6cd0$0a00a8c0@intranet.mp3s.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Elble wrote:

>>I tried switching to Redhat's 2.4.9-13 kernel and it acts Alot better.
>>Not only does 2.4.9-13 not get the 30 second delay, but it also seems to
>>take advantage of caching. 2.4.16 takes the same moment of time each
>>time, even tho it should have cached it all into memory the first time.
>>
> 
> Unless Red Hat has specifically added Andrea's new VM code to the 2.4.9
> kernel, then that kernel is still using the old VM.


Not exactly.  That kernel is -ac based (plus lots of other patches, some 
of them VM tweaks) and is a Van Riel VM.




-- 

  Doug Ledford <dledford@redhat.com>  http://people.redhat.com/dledford
       Please check my web site for aic7xxx updates/answers before
                       e-mailing me about problems

