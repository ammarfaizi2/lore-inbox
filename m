Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135521AbRDWDIc>; Sun, 22 Apr 2001 23:08:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135528AbRDWDIW>; Sun, 22 Apr 2001 23:08:22 -0400
Received: from james.kalifornia.com ([208.179.59.2]:575 "EHLO
	james.kalifornia.com") by vger.kernel.org with ESMTP
	id <S135521AbRDWDIQ>; Sun, 22 Apr 2001 23:08:16 -0400
Message-ID: <3AE39C9D.8010505@blue-labs.org>
Date: Sun, 22 Apr 2001 20:08:13 -0700
From: David <david@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.3-pre8 i686; en-US; rv:0.8.1+) Gecko/20010421
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.3+ sound distortion
In-Reply-To: <01042118044700.01268@victor> <20010422064655.A5682@thune.mrc-home.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  I have noticed a problem with sound lately.  I have a cs46xx card and 
it randomly gets distorted.  Normally I just reboot but on this last 
occurence I simply left it as it was.  The distortion sounds someone 
punched the speaker core, it's tinny and mangled.  Today it fixed itself 
out of the blue in the middle of playing a sound. All sound programs are 
equally affected.

It's only done this in the 2.4 series, I haven't had the desire to look 
into it.

David

Mike Castle wrote:

>On Sat, Apr 21, 2001 at 06:04:47PM +0200, Victor Julien wrote:
>
>>I have a problem with kernels higher than 2.4.2, the sound distorts when 
>>playing a song with xmms while the seti@home client runs. 2.4.2 did not have 
>>
>
>Would this be the same issue as describe in these threads:
>
>http://www.uwsg.indiana.edu/hypermail/linux/kernel/0104.0/0233.html
>http://www.uwsg.indiana.edu/hypermail/linux/kernel/0104.1/0231.html
>
>That is, the change in how nice is recalculated.
>
>mrc
>


