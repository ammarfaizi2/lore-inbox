Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278120AbRJLUcI>; Fri, 12 Oct 2001 16:32:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278122AbRJLUb4>; Fri, 12 Oct 2001 16:31:56 -0400
Received: from 216-175-173-2.client.dsl.net ([216.175.173.2]:20466 "HELO
	mail.fdfl") by vger.kernel.org with SMTP id <S278120AbRJLUb3>;
	Fri, 12 Oct 2001 16:31:29 -0400
Message-ID: <3BC75340.7090800@frontierd-us.com>
Date: Fri, 12 Oct 2001 16:32:00 -0400
From: Jelle Foks <jelle-kernel@frontierd-us.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011010
X-Accept-Language: en
MIME-Version: 1.0
To: Joel Jaeggli <joelja@darkwing.uoregon.edu>
Cc: John J Tobin <ogre@sirinet.net>, linux-kernel@vger.kernel.org
Subject: Re: Dual Athlon XP 1800+ on Tyan Thunder K7 or Tiger MP anyone?
In-Reply-To: <Pine.LNX.4.33.0110121203220.7418-100000@twin.uoregon.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joel Jaeggli wrote:

>On 11 Oct 2001, John J Tobin wrote:
>
>>On Thu, 2001-10-11 at 14:14, bill davidsen wrote:
>>
>>>In article <1002667385.1673.129.camel@phantasy> rml@tech9.net wrote:
>>>
>>>>Completely Agreed.  I am thinking of getting a dual AMD system for doing
>>>>more kernel work (tackle AMD and SMP).  My main machine is a P3 now.
>>>>
>>>The issue right now may be RAM cost. I just bought 512MB PC133 for
>>>$140/GB, while "registered PC2100" memory is about $900 from the same
>>>source. I think that's what the Tiger wants, isn't it?
>>>
>
>registered ecc dimms from crucial and kingston valueram are barely more
>than non-registered parts... I see the 512MB kingston registered ecc ddram
>part for $220 from a large mailorder house. the same spec part from
>corsair is still $489 from the same vendor. given the headaches that
>result from having to debug problems/faulty dimms on a machine with 2GB of
>ram and the non-trivial engineering that went into getting 4 reasonably
>spaced ddr dimm sockets on the mainboard. I expect registered ecc dimms
>will be well worth it, if only so that you can rule out the memory as the
>culprit if you have certain kinds of issues...
>

I have very good experience by testing with a memtest boot floppy (see 
www.memtest86.com), and running overnight or a whole week-end. All new 
configurations I build get a long memtest before deployment.

Jelle.

>
>
>joelja
>
>
>>>--
>>>bill davidsen <davidsen@tmr.com>
>>>
>>The Tyan Tiger and Thunder both take Registered DDR DIMMs. Though
>>anandtech got it running using only one pair of unregistered, other
>>combinations of unregistered failed to boot. There are also no SMP
>>athlon chipsets that use PC133.
>>
>>
>>
>



