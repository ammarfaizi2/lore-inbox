Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270715AbTGVKf3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 06:35:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270752AbTGVKf2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 06:35:28 -0400
Received: from main.gmane.org ([80.91.224.249]:5256 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S270715AbTGVKfV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 06:35:21 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Andreas =?ISO-8859-15?Q?B=E4urle?= <a.baeurle@web.de>
Subject: Re: XP vfat partitions
Date: Tue, 22 Jul 2003 12:46:16 +0200
Message-ID: <bfj4r3$1nh$1@main.gmane.org>
References: <bfechu$tse$1@main.gmane.org> <20030721175147.GD1158@matchmail.com> <bfhp94$1cr$1@main.gmane.org> <3F1CB567.5050103@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8Bit
X-Complaints-To: usenet@main.gmane.org
Mail-Copies-To: a.baeurle@web.de
User-Agent: KNode/0.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yuliy Pisetsky wrote:

> andreas baeurle wrote:
> 
>>Mike Fedyk wrote:
>>
>>  
>>
>>>On Sun, Jul 20, 2003 at 05:27:03PM +0200, andreas wrote:
>>>    
>>>
>>>>My question is howto mount a Xp-vfat partition with 2.6 kernel.
>>>>In my fstab is following entry:
>>>>/dev/hda2       /windows/C      vfat
>>>>users,gid=users,umask=0002,iocharset=iso8859-1 code=437 0 0
>>>>      
>>>>
>>>Yes?
>>>
>>>And what is your error message, and why do you think it's not working
>>>anymore?
>>>    
>>>
>>I have 3 Partitions with vfat
>>the error message is:
>><3>FAT: Unrecognized mount option code
>><3>FAT: Unrecognized mount option code
>><3>FAT: Unrecognized mount option code
>>in boot.msg
>>I have testet lsmod it shows me one vfat module loaded but not used
>>
>>thanks
>>andreas
>>
> hmmm... why is the code=437 separate? Try replacing the space before
> code=437 with a comma.
> -Yuliy Pisetsky
there is a comma I have it lost with copy & paste in kmail!?
@Andries Brouwer 
I will test it with codepage

Andreas Bäurle

