Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317277AbSGIALV>; Mon, 8 Jul 2002 20:11:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317278AbSGIALU>; Mon, 8 Jul 2002 20:11:20 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:22546 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S317277AbSGIALQ>;
	Mon, 8 Jul 2002 20:11:16 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: system call 
In-reply-to: Your message of "09 Jul 2002 01:59:42 +0200."
             <1026172783.2084.26.camel@server1> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 09 Jul 2002 10:13:47 +1000
Message-ID: <22091.1026173627@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09 Jul 2002 01:59:42 +0200, 
Vladimir Zidar <vladimir@mindnever.org> wrote:
>On Mon, 2002-07-08 at 17:16, Randy.Dunlap wrote:
>>   http://www.xenotime.net/linux/syscall_ex/
>> contains a howto, kernel patch, and test program.
>
> And how to choose goot syscall number ? Are some numbers pre-reserved
>to 'private' syscalls ? What numbers are free to use, without fear that
>new kernel release will just jump over them !?
> And what about an idea to be able to add syscall by name, from loadab;e
>module of course.  Userland application will then resolve 'name' to
>number at startup, and use it just as ordinary syscall ?

http://marc.theaimsgroup.com/?t=100902098800001&r=1&w=2.  There were
alternative patches going around, primarily from Benjamin LaHaise.
Linus did not want any of the patches.

