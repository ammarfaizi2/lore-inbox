Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311381AbSCNIAk>; Thu, 14 Mar 2002 03:00:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311395AbSCNIA2>; Thu, 14 Mar 2002 03:00:28 -0500
Received: from adsl-196-233.cybernet.ch ([212.90.196.233]:49915 "HELO
	mailphish.drugphish.ch") by vger.kernel.org with SMTP
	id <S311381AbSCNIAN>; Thu, 14 Mar 2002 03:00:13 -0500
Message-ID: <3C905894.90407@drugphish.ch>
Date: Thu, 14 Mar 2002 09:00:20 +0100
From: Roberto Nibali <ratz@drugphish.ch>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020306
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Question about the ide related ioctl's BLK* in 2.5.7-pre1 kernel
In-Reply-To: <3C9007F5.1000003@drugphish.ch> <3C900A11.55BA4B32@zip.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> They got collaterally damaged in the IDE "cleanup".  The patch at
> http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.6/dallocbase-10-readahead.patch
> resurrects them.

Oh, I see. I've missed that patch of yours. I certainly enjoyed (maybe 
much to your grief) the comments in the code :).

Is GFP_READAHEAD still a wish or did you drop that idea? AFAICS you only 
addressed the i386 arch with that patch, do you want the specific arch 
maintainers to clean up their part when your patch is finished?

Cheers,
Roberto Nibali, ratz

