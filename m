Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315220AbSDWO1x>; Tue, 23 Apr 2002 10:27:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315221AbSDWO1w>; Tue, 23 Apr 2002 10:27:52 -0400
Received: from tolkor.sgi.com ([192.48.180.13]:64988 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id <S315220AbSDWO1u>;
	Tue, 23 Apr 2002 10:27:50 -0400
Message-ID: <3CC56FE9.1080303@sgi.com>
Date: Tue, 23 Apr 2002 09:30:01 -0500
From: Stephen Lord <lord@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011226
X-Accept-Language: en-us
MIME-Version: 1.0
To: m.knoblauch@TeraPort.de
CC: kernel@expansa.sns.it,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: XFS in the main kernel
In-Reply-To: <3CC56355.E5086E46@TeraPort.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Knoblauch wrote:

>>Re: XFS in the main kernel
>>
>>From: Luigi Genoni (kernel@Expansa.sns.it)
>>On Tue, 23 Apr 2002, Keith Owens wrote:
>>
>>>On 22 Apr 2002 18:55:20 +0200,
>>>wichert@cistron.nl (Wichert Akkerman) wrote:
>>>
>>>>In article <3CC427F4.12C40426@fnal.gov>,
>>>>Dan Yocum <yocum@fnal.gov> wrote:
>>>>
>>>>>I know it's been discussed to death, but I am making a formal request to you
>>>>>to include XFS in the main kernel. We (The Sloan Digital Sky Survey) and
>>>>>many, many other groups here at Fermilab would be very happy to have this in
>>>>>the main tree.
>>>>>
>>>>Has XFS been proven to be completely stable
>>>>
>>>As much as any other filesystem. "There are no bugs in filesystem XYZ.
>>>That just means that you have not looked hard enough." :) There is a
>>>daily QA suite that XFS is run through.
>>>
>>In the reality the inclusion on XFS in the 2.5 tree would probably move
>>more peole to use it, and so also to eventually trigger bugs, to report
>>them, sometimes to fix them.
>>This way XFS would improve faster, and of course that would be a
>>good thing.
>>
>
> definitely. Unless XFS is in the mainline kernel (marked as
>experimantal if necessary) it will not get good exposure.
>
> The most important (only) reason I do not use it (and recommend our
>customers against using it) is that at the moment it is impossible to
>track both the kernel and XFS at the same time. This is a shame, because
>I think that for some application XFS is superior to the other
>alternatives (can be said about the other alternatives to :-).
>

You would be surprised about the level of exposure XFS is getting, a lot 
more
than you might realize. It is in everything from settop boxes and fiber 
channel
switches to NAS boxes, those folks in general do not want to advertise. 
Here are
a few larger scale installations out there:

http://oss.sgi.com/projects/xfs/xfs_users.html

Steve


