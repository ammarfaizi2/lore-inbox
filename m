Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269517AbRH0WYq>; Mon, 27 Aug 2001 18:24:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269541AbRH0WYd>; Mon, 27 Aug 2001 18:24:33 -0400
Received: from web20001.mail.yahoo.com ([216.136.225.46]:28433 "HELO
	web20001.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S269436AbRH0WXp>; Mon, 27 Aug 2001 18:23:45 -0400
Message-ID: <20010827222401.86285.qmail@web20001.mail.yahoo.com>
Date: Mon, 27 Aug 2001 15:24:01 -0700 (PDT)
From: Raghava Raju <vraghava_raju@yahoo.com>
Subject: Kernel stack...
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 Hi 

   Kindly provide me with some basic insights
  into kernel.

 1) I want to know exact structure of kernel stack
  and process stack in memory. It would be helpful
  if description includes approximate memory addresses
  of kernel stack,process stack, and different regions
  in kernel stack and process stack. What happens 
  if there are multiple processes.

 2) What about "current" data structure. Where is it
  located  on memory. If I am not wrong it will be 
  just below the process stack.

 3)Which variable to use to access (I am in kernel
   code) kernel stack. In "task_struct" 
   kernel_stack_page is not defined. Mine is 
   "linux 2.4.2 mvista".

  I am not subscribed to this list, kindly send
  me the reply to vraghava_raju@yahoo.com .

__________________________________________________
Do You Yahoo!?
Make international calls for as low as $.04/minute with Yahoo! Messenger
http://phonecard.yahoo.com/
