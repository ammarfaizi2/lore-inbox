Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317814AbSFMUGB>; Thu, 13 Jun 2002 16:06:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317815AbSFMUGA>; Thu, 13 Jun 2002 16:06:00 -0400
Received: from mail1.btigate.com ([216.235.160.81]:19617 "HELO
	mail1.btigate.com") by vger.kernel.org with SMTP id <S317814AbSFMUGA>;
	Thu, 13 Jun 2002 16:06:00 -0400
Message-Id: <5.1.0.14.2.20020613150319.00a09360@mail.btinet.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Thu, 13 Jun 2002 15:05:53 -0500
To: linux-kernel@vger.kernel.org
From: Jim Nelson <jimnelson@btinet.net>
Subject: Re: Locking CD tray w/o opening device
In-Reply-To: <1023771645.1519.3.camel@UberGeek>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 12:00 AM 6/11/02 -0500, you wrote:
>You could echo "1" >/proc/sys/dev/cdrom/lock
>
>If you do this, even when a cd is *not* in the drive it will be locked.
>For information like this, it might be best to open xchat, and head to
>openprojects.net and join #linuxhelp. This is a good question, just
>perhaps  not right for the lkml?


Um, No.  My /proc/sys/dev/cdrom/lock defaults to a 1, and the drive opens 
when a disc is not present at the touch of the button. 


