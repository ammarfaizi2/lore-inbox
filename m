Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263319AbSJTRhf>; Sun, 20 Oct 2002 13:37:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263320AbSJTRhf>; Sun, 20 Oct 2002 13:37:35 -0400
Received: from pop.gmx.de ([213.165.64.20]:32069 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S263319AbSJTRhe>;
	Sun, 20 Oct 2002 13:37:34 -0400
Message-Id: <5.1.0.14.2.20021020193521.00b9a748@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sun, 20 Oct 2002 19:40:40 +0200
To: Floydsmith@aol.com, linux-kernel@vger.kernel.org
From: Mike Galbraith <efault@gmx.de>
Subject: Re: loadlin with 2.5.?? kernels
Cc: Floydsmith@aol.com
In-Reply-To: <1a9.a96af34.2ae43a18@aol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 12:55 PM 10/20/2002 -0400, Floydsmith@aol.com wrote:
>In a message dated 10/20/2002 9:03:34 AM Eastern Daylight Time, 
>efault@gmx.de writes:
>
>
>>Subj:loadlin with 2.5.?? kernels
>>Date:10/20/2002 9:03:34 AM Eastern Daylight Time
>>From:<mailto:efault@gmx.de>efault@gmx.de
>>To:<mailto:linux-kernel@vger.kernel.org>linux-kernel@vger.kernel.org
>>Sent from the Internet
>>
>>
>>
>>Greetings,
>>
>>I hadn't had time to build/test kernels since 2.5.8-pre3.  I now find that
>>loadlin doesn't work on my box any more.  Is this a known problem?  If so,
>>when did it quit working?  (loadlin obsolete?  other?)
>>
>>At the moment, the only way I have to boot is via floppy.
>
>
>loadlin will not work with any kernel that is 1024k or greater in size.
>There is a replacement named "linld" at:
>http://www.tux.org/pub/people/kent-robotti/looplinux/index.html
>which help you.

Yeah, that's always been a pain, but that's not what I'm hitting (violent 
reboot).  I'll give linld (thanks!) a shot, but mostly, I want my dearly 
beloved loadlin back ;-)

         -Mike


