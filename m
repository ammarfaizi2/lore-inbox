Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268145AbRHAUoL>; Wed, 1 Aug 2001 16:44:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268150AbRHAUoB>; Wed, 1 Aug 2001 16:44:01 -0400
Received: from web20009.mail.yahoo.com ([216.136.225.72]:57349 "HELO
	web20009.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S268145AbRHAUnx>; Wed, 1 Aug 2001 16:43:53 -0400
Message-ID: <20010801204401.21619.qmail@web20009.mail.yahoo.com>
Date: Wed, 1 Aug 2001 13:44:01 -0700 (PDT)
From: Raghava Raju <vraghava_raju@yahoo.com>
Subject: Basic question..
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



   Hi

        I am new to kernel programming. I have
   just written a module consisting of init and
cleanup
   functions. I call init function of the module in
   kernel initialization function. So when system
   comes up, it shows that it entered module init 
   function(printk in "init" print some string), but 
   when I do lsmod it is not there in  list of 
   modules. But if I do insmod module, the module is
   listed in lsmod output. So is it that calling init
   module and insmod are not equivalent?

   Thank You
   Raghava.



__________________________________________________
Do You Yahoo!?
Make international calls for as low as $.04/minute with Yahoo! Messenger
http://phonecard.yahoo.com/
