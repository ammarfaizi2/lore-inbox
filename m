Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292390AbSBYWr1>; Mon, 25 Feb 2002 17:47:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292379AbSBYWqK>; Mon, 25 Feb 2002 17:46:10 -0500
Received: from fe170.worldonline.dk ([212.54.64.199]:38661 "HELO
	fe170.worldonline.dk") by vger.kernel.org with SMTP
	id <S292382AbSBYWpo>; Mon, 25 Feb 2002 17:45:44 -0500
Message-ID: <3C7ABF22.2030705@dif.dk>
Date: Mon, 25 Feb 2002 23:48:02 +0100
From: Jesper Juhl <jju@dif.dk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011126 Netscape6/6.2.1
X-Accept-Language: en-us
MIME-Version: 1.0
To: Mike Fedyk <mfedyk@matchmail.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: Linux 2.4.18 - the missing patch issue
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
 > > I suggest that instead of the previously proposed solutions an effort
 > > should instead be made to release 2.4.19 relatively fast. Instead of
 > > including a lot of fixes, only include the most critical known fixes
 > in
 > > 2.4.19-pre1 (and maybe -pre2), then go to -rc1 as soon as possible and
 >
 > > get 2.4.19 out the door pretty fast with important fixes and leave all
 >
 > > other stuff for 2.4.20-pre1
 > >
 >
 > Does anyone know how long this bug has been in the kernel?
 >
 > If it's an old bug, 2.4.19-pre1 already has the fix, just like rc4
 > did...
 >
 > This *one* bug isn't big enough to hurry, IMO.

You are probably right, a resonably harmless bug should not be enough to 
justify a rushed 2.4.19 release. But the confusion and "bad publicity" 
/might/ justify it.
I personally don't think that the publicity issue is something that the 
kernel people should be concerned about, but user confusion probably is 
- confused users submitting bug reports and/or patches against two 
different 2.4.18 versions sounds to me like something that you want to 
keep to a minimum, and the only way I see of removing that confusion is 
to get 2.4.18 out of the way and replaced with 2.4.19 as soon as possible.

- Jesper Juhl - jju@dif.dk -



