Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280776AbRKLN4h>; Mon, 12 Nov 2001 08:56:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280784AbRKLN41>; Mon, 12 Nov 2001 08:56:27 -0500
Received: from thebsh.namesys.com ([212.16.0.238]:13834 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S280776AbRKLN4X>; Mon, 12 Nov 2001 08:56:23 -0500
Message-ID: <3BEFD4E0.6050708@namesys.com>
Date: Mon, 12 Nov 2001 16:55:44 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010923
X-Accept-Language: en-us
MIME-Version: 1.0
To: arjanv@redhat.com
CC: linux-kernel@vger.kernel.org, yura@namesys.com
Subject: Re: Oops in reiserfs w/2.4.7-10
In-Reply-To: <Pine.LNX.4.33.0111122233530.26293-100000@bad-sports.com> <3BEFBDE0.6080804@namesys.com> <3BEFC301.A92C64D4@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:

>>Please upgrade to a recent linus kernel.  I don't know what went into
>>RedHat 7.2, but secondhand reports are that reiserfs is not stable in
>>that kernel.
>>
>
>Please stop badmouthing people that don't happen to pay you. (and don't
>mis-spell their name).
>
>The Red Hat Linux 7.2 kernels don't have reiserfs patches so all bugs
>are
>yours and yours alone.....
>
>
If I understand correctly that it is 2.4.7 that went in, and there were 
no memory manager or vfs patches, then you are almost surely correct, 
and it probably has some relatively rare bugs fixed recently but is 
reasonably stable on the whole.  He should still upgrade to a recent 
Linus kernel though.  Yura, have you tested this kernel yet?  Do you 
recognize this bug as a fixed bug?

Hans

