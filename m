Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317286AbSGTBCI>; Fri, 19 Jul 2002 21:02:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317299AbSGTBCH>; Fri, 19 Jul 2002 21:02:07 -0400
Received: from sccrmhc01.attbi.com ([204.127.202.61]:5551 "EHLO
	sccrmhc01.attbi.com") by vger.kernel.org with ESMTP
	id <S317286AbSGTBCF>; Fri, 19 Jul 2002 21:02:05 -0400
Message-ID: <3D38B485.8020503@namesys.com>
Date: Sat, 20 Jul 2002 04:53:25 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: Andreas Dilger <adilger@clusterfs.com>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>,
       "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
       Guillaume Boissiere <boissiere@adiglobal.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6] Most likely to be merged by Halloween... THE LIST]
References: <Pine.LNX.4.44L.0207192144190.12241-100000@imladris.surriel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What I was advocating was a schedule of:

1) feature submission deadline

2) period of working through feature backlog

3) feature acceptance ending date

Most release management teams in the industry do things this way, 
and.... I'd better say no more, those words will lose me the argument.;-)

I'll admit that in most companies the features to be merged backlog 
period lasts for only a few days, and due to the difference in scale, it 
would probably last a few weeks for Linux, but in my egocentrism I 
really think that providing submitters with certainty as to what they 
need to do to get a patch in is a good thing.

I understand though that maybe the needs of the submitters aren't the 
most important thing for Linux as a whole, and so others will 
legitimately disagree.

Hans

Rik van Riel wrote:

>On Sat, 20 Jul 2002, Hans Reiser wrote:
>
>  
>
>>That could be dealt with by letting people resend feature containing
>>patches that were first submitted by Halloween (forward porting them as
>>things progress) until they get a rejection or Linus announces he has
>>taken all that he wants from the queue.
>>    
>>
>
>I hope the Halloween feature freeze really will be a feature
>freeze.  Nothing is more frustrating than having a "stable
>kernel" broken every second release by yet another feature.
>
>If we all restrain ourselves 2.6 will be stable soon and 2.7
>will be started shortly after. Backporting "essential" features
>from 2.7 into a _stable_ 2.6 will be so much easier than trying
>to stabilise a 2.6-pre that's full to the brim of not-yet-stable
>new features.
>
>regards,
>
>Rik
>  
>


-- 
Hans



