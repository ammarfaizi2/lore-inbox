Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291988AbSBNXuA>; Thu, 14 Feb 2002 18:50:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291989AbSBNXtu>; Thu, 14 Feb 2002 18:49:50 -0500
Received: from nycsmtp2out.rdc-nyc.rr.com ([24.29.99.227]:409 "EHLO
	nycsmtp2out.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id <S291988AbSBNXtl>; Thu, 14 Feb 2002 18:49:41 -0500
Message-ID: <3C6C4D12.4080701@nyc.rr.com>
Date: Thu, 14 Feb 2002 18:49:38 -0500
From: John Weber <weber@nyc.rr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020206
X-Accept-Language: en-us
MIME-Version: 1.0
To: Rich Baum <richbaum@acm.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [OOPS] Linux 2.5 and Parallel Port Zip 100
In-Reply-To: <3C62DABF.5040303@nyc.rr.com> <8A8F64D3BD7@coral.indstate.edu> <3C670E0D.2040402@nyc.rr.com> <90D37E966D1@coral.indstate.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>
>
>I was wondering if you had received my patch.  I had mail problems on Monday 
>and lost messages.
>
>Rich
>

I did try out the patch.  

The first time I used the driver there was major damage to the fs on one 
of my zip disks (so the "mv bigassfile /mnt/zip/" failed miserably), but 
I couldn't be sure that the driver was the root cause so I didn't email 
you about it.

Thereafter, I tried mounting/unmounting, writing new filesystems, 
writing/reading large files...
everything checked out fine.

You should definitely forward your patch to LKML and Linus.

