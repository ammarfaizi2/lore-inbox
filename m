Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261706AbSJHW1o>; Tue, 8 Oct 2002 18:27:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261644AbSJHW0O>; Tue, 8 Oct 2002 18:26:14 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:33291 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S261698AbSJHW0A>;
	Tue, 8 Oct 2002 18:26:00 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: vpath broken in 2.5.41 
In-reply-to: Your message of "Tue, 08 Oct 2002 09:35:56 EST."
             <Pine.LNX.4.44.0210080932210.32256-100000@chaos.physics.uiowa.edu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 09 Oct 2002 08:31:29 +1000
Message-ID: <2593.1034116289@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Oct 2002 09:35:56 -0500 (CDT), 
Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de> wrote:
>On Tue, 8 Oct 2002, Keith Owens wrote:
>> This is one of the problems that kbuild 2.5 was designed to handle, to
>> cope with modules built from code in multiple directories.  I support
>> what the developer wants to do, not restrict the developer to what the
>> kernel build can handle.
>
>So would you mind telling me what arch/i386/drivers/Makefile.in would 
>look like for a module which is built from sources in arch/i386/drivers 
>and drivers/oprofile ?

Do you really expect me to help you sort out the mess you have made of
kernel build?  So you can pick more ideas and bug fixes from kbuild 2.5
and claim the credit for them?  Forget it!

