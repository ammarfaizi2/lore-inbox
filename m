Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288566AbSA2D3H>; Mon, 28 Jan 2002 22:29:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288614AbSA2D25>; Mon, 28 Jan 2002 22:28:57 -0500
Received: from lacrosse.corp.redhat.com ([12.107.208.154]:5146 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S288566AbSA2D2o>; Mon, 28 Jan 2002 22:28:44 -0500
Message-ID: <3C5616EA.1040101@redhat.com>
Date: Mon, 28 Jan 2002 22:28:42 -0500
From: Doug Ledford <dledford@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7+) Gecko/20020120
X-Accept-Language: en-us
MIME-Version: 1.0
To: Neale Banks <neale@lowendale.com.au>
CC: linux-kernel@vger.kernel.org, Alan Cox <alan@redhat.com>
Subject: Re: [PATCH] i810 driver update.
In-Reply-To: <Pine.LNX.4.05.10201291422170.1513-200000@marina.lowendale.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neale Banks wrote:
>>Yeah, there's a vast difference there.  I would guess that the difference is 
>>the presence of S/PDIF support in the 2.4+ .17 driver version and none in 
>>the 2.2 version.  Email me the whole 0.17 file you have there (off-list) and 
>>I'll see about integrating the changes.
>>
> 
> 2.2's i810_audio is attached. Let's know if there's anything else you
> need.


Wow!!  How in the hell did the version number 0.17 get on that file! 
There's over 2500+ lines of diff between it and a real 0.17 file.  There's 
over 1600 lines of diff between it and a 0.05 i810 driver file and that's 
the closest one I could find!  (I don't have any of the versions prior to 
0.05 in my immediate possesion, so it might come closer to a 0.04).  Merging 
is pretty much a waste of time.  I think it would be faster to port the 
current driver over.  I don't currently have that much free time though, so 
I'll have to leave this to someone else.  If it doesn't get done pretty soon 
then I might be able to make the time, but no guarantees :-/



-- 

  Doug Ledford <dledford@redhat.com>  http://people.redhat.com/dledford
       Please check my web site for aic7xxx updates/answers before
                       e-mailing me about problems

