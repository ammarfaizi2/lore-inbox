Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273257AbRINCWq>; Thu, 13 Sep 2001 22:22:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273258AbRINCWg>; Thu, 13 Sep 2001 22:22:36 -0400
Received: from cpe-24-221-114-147.az.sprintbbd.net ([24.221.114.147]:3968 "EHLO
	localhost.digitalaudioresources.org") by vger.kernel.org with ESMTP
	id <S273257AbRINCWW>; Thu, 13 Sep 2001 22:22:22 -0400
Message-ID: <3BA169DF.3060306@digitalaudioresources.org>
Date: Thu, 13 Sep 2001 19:22:23 -0700
From: David Hollister <david@digitalaudioresources.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010808
X-Accept-Language: en-us
MIME-Version: 1.0
To: Anton Altaparmakov <aia21@cus.cam.ac.uk>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Conquering the Athlon optimization troubles
In-Reply-To: <Pine.SOL.3.96.1010914012401.21012A-100000@virgo.cus.cam.ac.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Altaparmakov wrote:
> On Thu, 13 Sep 2001, David Hollister wrote:
> 
>>My motherboard is the Epox 8KTA3+, and I'm running an Athlon 1.4GHz.
>>
>>Epox was kind enough to mail me a new BIOS chip to replace my locked
>>chip.  This chip contained a version of the BIOS that I believe was
>>dated 8/6/2001 (I don't feel like rebooting again to find out).  Suffice
>>it to say, that version is not listed on their website, but there is an
>>even newer one.  For anybody with the 8KTA3 or 8KTA3+, the BIOS page is
>>located at http://www.epox.com/html/english/support/motherboard/bios/8kt3.htm
>>
> 
> Maybe you meant 9/6/2001. That is the latest available version. From only
> 5 days ago.

No.  I just rebooted to check.  It's dated 8/16/2001.  Strange.

>>Anyway, I was running the BIOS dated 3/5/2001 up until now.
>>
> 
> That was ancient! There were quite a few releases between then and now.

But I couldn't update because my BIOS chip was locked.

>>The point to all this is that with the newer BIOS, my machine is now up and 
>>running absolutely fine with Athlon optimization turned on.
>>
> 
> Congratulations! (-: I would recommend you to run a long memtest86 as well
> in particular tests 5 and 8. - They are the ones that used to fail for me
> with the inappropriate memmory settings...

Thanks for the suggestion.



-- 
David Hollister
Driversoft Engineering:  http://devicedrivers.com
Digital Audio Resources: http://digitalaudioresources.org

