Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289072AbSAIXWg>; Wed, 9 Jan 2002 18:22:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289068AbSAIXWZ>; Wed, 9 Jan 2002 18:22:25 -0500
Received: from freeside.toyota.com ([63.87.74.7]:16137 "EHLO
	freeside.toyota.com") by vger.kernel.org with ESMTP
	id <S289075AbSAIXWM>; Wed, 9 Jan 2002 18:22:12 -0500
Message-ID: <3C3CD09B.7050801@lexus.com>
Date: Wed, 09 Jan 2002 15:22:03 -0800
From: J Sloan <jjs@lexus.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011221
X-Accept-Language: en-us
MIME-Version: 1.0
To: walter <walt@nea-fast.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: new kernel --this is wierd
In-Reply-To: <200201092250.RAA03139@int1.nea-fast.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A shot in the dark:

echo "0" > /proc/sys/net/ipv4/tcp_ecn

cu

jjs

walter wrote:

>This may be a SGI question...
>
>After upgrading to kernel-2.4.14-SGI_XFS_1.0.2 I can no longer connect to 
>www.zdnet.com. I can connect to any other web site. 
>
>I've tried kde konqueror-2.2.2-1, netscape-communicator-4.77-0.6.2, 
>netscape-navigator-4.77-0.6.2, netscape-communicator-4.78-2, and the latest 
>release of opera. 
>
>I've used rpm to verify all depends. I get no error messages anywhere that I 
>can find. If I boot to winsucks98 I have no problem(boo) so I know its not a 
>firewall problem. Does anyone have any ideas what the problem may be or a way 
>to figure out whats happening? Someone I work with suggested process 
>accouting.
>
>Thanks!
>


