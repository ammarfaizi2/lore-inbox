Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318879AbSHLXuG>; Mon, 12 Aug 2002 19:50:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318880AbSHLXuG>; Mon, 12 Aug 2002 19:50:06 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:45572 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S318879AbSHLXuF>;
	Mon, 12 Aug 2002 19:50:05 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: "Dhr N. Van Alphen" <mastex@servicez.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel 2.5.31 make menuconfig 
In-reply-to: Your message of "Mon, 12 Aug 2002 20:26:23 +0200."
             <008401c2422d$c34de9e0$0200010a@jennifer> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 13 Aug 2002 09:52:24 +1000
Message-ID: <5003.1029196344@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Aug 2002 20:26:23 +0200, 
"Dhr N. Van Alphen" <mastex@servicez.org> wrote:
>After unpacking kernel 2.5.31 source and running 'make menuconfig"
>its fails with this error:
>
>In file included from /usr/include/netinet/in.h:212,
>                 from fixdep.c:107:
>/usr/include/bits/socket.h:298: asm/socket.h: No such file or directory
>make[1]: *** [fixdep] Error 1

http://www.uwsg.iu.edu/hypermail/linux/kernel/0007.3/0587.html

