Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261932AbSITJGQ>; Fri, 20 Sep 2002 05:06:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261944AbSITJGQ>; Fri, 20 Sep 2002 05:06:16 -0400
Received: from web40502.mail.yahoo.com ([66.218.78.119]:45218 "HELO
	web40502.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S261932AbSITJGO>; Fri, 20 Sep 2002 05:06:14 -0400
Message-ID: <20020920091114.46162.qmail@web40502.mail.yahoo.com>
Date: Fri, 20 Sep 2002 02:11:14 -0700 (PDT)
From: Seaman Hu <seaman_hu@yahoo.com>
Subject: Re: What will happen when disk(ext3) is full while i continue to operate files ?
To: Seaman Hu <seaman_hu@yahoo.com>, ext3-users@redhat.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020920073927.71003.qmail@web40504.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry. I probably didn't make it clear. 
My system is ok when first msg "EXT3-fs error (device
sd(8,2)) in ext3_new_inode: error 28" appears.
However, it will crash after millions of the same msg.
Is there some kind of buffer full to cause the crash?

thanks in advance.

Seaman


--- Seaman Hu <seaman_hu@yahoo.com> wrote:
> I am sorry if you receive it twice. since the
> mail-list said that i can't send mail to it unless i
> become one its member.
> 
> hi,
>    My system will crash when the disk(ext3) is full
> while i continue to launch 50 proceses to operate
> files(such as create, rm, mv, ...). Does ext3 have
> such a capability to stop journaling the changes
> when
> it finds there is no space left? or which source
> file
> of ext3 do i need to check this function?
> 
>    My System info:
>     Redhat 7.3    Linux Kernel: 2.4.18-17
>     / : ext3 1.6G   /boot : ext3 60M
> 
>    I am sorry that I will attach the oops next time
> since i am still restoring my poor system.  :(
> 
>    Any opinions will be highly appriciated. Thanks
> in
> advance. :)
> 
> Seaman
> 
> __________________________________________________
> Do You Yahoo!?
> Yahoo! Finance - Get real-time stock quotes
> http://finance.yahoo.com
> 
> 
> 
> _______________________________________________
> Ext3-users mailing list
> Ext3-users@redhat.com
>
https://listman.redhat.com/mailman/listinfo/ext3-users


__________________________________________________
Do You Yahoo!?
Yahoo! Finance - Get real-time stock quotes
http://finance.yahoo.com
