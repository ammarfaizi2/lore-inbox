Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130855AbQKGEJx>; Mon, 6 Nov 2000 23:09:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131004AbQKGEJn>; Mon, 6 Nov 2000 23:09:43 -0500
Received: from [209.143.110.29] ([209.143.110.29]:62985 "HELO
	mail.the-rileys.net") by vger.kernel.org with SMTP
	id <S130855AbQKGEJY>; Mon, 6 Nov 2000 23:09:24 -0500
Message-ID: <3A07806B.239BC895@the-rileys.net>
Date: Mon, 06 Nov 2000 23:09:36 -0500
From: David Riley <oscar@the-rileys.net>
X-Mailer: Mozilla 4.74 (Macintosh; U; PPC)
X-Accept-Language: en,pdf
MIME-Version: 1.0
To: Joe Harrington <jharring@micron.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: kernel
In-Reply-To: <004d01c0486e$9777ff00$53b613d1@micron.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joe Harrington wrote:
> 
> Sorry about the question to do with visuall gcc. Alot of people seemed to
> get a intolerable response to my question. The reason I posted it here was
> a) I am lazy, b) On all the sites to do with Kdevelop the download links are
> down, and c) I wanted to use the program to compile such files as schedule.c
> and other scheduling algorithms I create. What do most of you use to comile
> the kernel, just good ole' command line gcc.

Definitely.  As much as I appreciate the efforts to make a workable
end-user GUI for Linux, I think people are still going to have to get
used to using command-line tools at the moment.  For what it's worth,
there are two visual configuration options for the kernel; for a text
console, you can use "make menuconfig" while you can use "make xconfig"
if you're really into X.  Personally, I found the standard "make config"
useful only the first time around, because it forced me to look at every
option, but it's much easier to undo mistakes using menuconfig or xconfig.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
