Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264503AbRFYNTg>; Mon, 25 Jun 2001 09:19:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264511AbRFYNT0>; Mon, 25 Jun 2001 09:19:26 -0400
Received: from f237.law14.hotmail.com ([64.4.21.237]:14092 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S264503AbRFYNTK>;
	Mon, 25 Jun 2001 09:19:10 -0400
X-Originating-IP: [194.236.106.153]
From: "John Nilsson" <pzycrow@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Some experience of linux on a Laptop
Date: Mon, 25 Jun 2001 15:19:03 +0200
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F237A9bbbJXncnm5c4G000148cc@hotmail.com>
X-OriginalArrivalTime: 25 Jun 2001 13:19:04.0394 (UTC) FILETIME=[67FDF2A0:01C0FD79]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > 8: A way to change kernel without rebooting. I have no diskdrive or 
>cddrive
> > in my laptop so I often do drastic things when I install a new 
>distribution.
>
>Well, don't do drastic things then, if that cause problems!

=) First of all that part was intended as a joke ;) but what I meant is 
this.

I think it was when installing debian I wanted to change back to ext2 from 
reiserfs. Trouble is for some reason their install program needs kernel 
2.2.x which doesn't support reiserfs. So I had to make an ext2 partition to 
save all files I wanted to save. Thats when I noticed that their install 
program had managed to delete all my modules. So a reboot would mean loss of 
reiserfs support, but not to reboot would mean no ext2 support... tricky. 
Well I tar'ed the damn files and dd 'em to the swap parttion right after the 
debianinstall disk. Hmmm.... come to think of it I don't remmber why I 
wanted to change kernel on the fly... The problem was that the modules was 
in mem only.

well well...

and when it comes to the slow X..
actually eaven xdm hangs fairly often. I was running blackbox when it 
didn't, but then blackbox would hang.


I did't really mean to drop a request list on your laps, just thought that 
some feed back keeps the mind going.

/John Nilsson
_________________________________________________________________________
Get Your Private, Free E-mail from MSN Hotmail at http://www.hotmail.com.

