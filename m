Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315199AbSDWNe7>; Tue, 23 Apr 2002 09:34:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315201AbSDWNe6>; Tue, 23 Apr 2002 09:34:58 -0400
Received: from f236.law11.hotmail.com ([64.4.17.236]:13073 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S315199AbSDWNe5>;
	Tue, 23 Apr 2002 09:34:57 -0400
X-Originating-IP: [137.204.212.214]
From: "gio zanei" <il_boba@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: undefined reference to printk()
Date: Tue, 23 Apr 2002 15:34:51 +0200
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Message-ID: <F236cWcHoWRwE67G7lU00005dc6@hotmail.com>
X-OriginalArrivalTime: 23 Apr 2002 13:34:52.0453 (UTC) FILETIME=[A5D4C550:01C1EACB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi to all,
i need to compile a small program that i made. WHen i try to do it, it 
compiles all right with the -c option ( that is i get the .o file), but if i 
do even the linking it just keep giving me the undefined reference error to 
some kernel functions that i need to use. In particular are the printk, 
filp_open, generic_file_read....  I have included the header files that 
declare them ( kernel.h and fs.h) and i have compiled the program with the 
-D__KERNEL__ and other option used by the compiler when it wants to compile 
a module in the kernel. I tried in many different ways but the error in the 
linking is always the same.
thank you,
boba


_________________________________________________________________
MSN Foto è il modo più semplice per condividere e stampare le tue foto: 
http://photos.msn.com/support/worldwide.aspx

