Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750722AbVJJIj2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750722AbVJJIj2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 04:39:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750723AbVJJIj2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 04:39:28 -0400
Received: from web35814.mail.mud.yahoo.com ([66.163.179.183]:15278 "HELO
	web35814.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750722AbVJJIj1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 04:39:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=N1egOlSGnDy6rX+7ZyVyOL+bX621fN7f6qfreO2Dh1xJe83hKRnxX9fvvioPnbaFaBohzp/z+2bK8+clArRJBgyroho2BhRW+9zjDnk3iTj/HmHXbdEspOhiIZ/pZVqj79Mnr8BrHfH+Yvz4H+Ff6cLbCoYjRq1uCa6hDbrScjI=  ;
Message-ID: <20051010083927.92193.qmail@web35814.mail.mud.yahoo.com>
Date: Mon, 10 Oct 2005 01:39:27 -0700 (PDT)
From: nix noob <nixnoob1618@yahoo.com>
Subject: some peculiar problem debugging in gdb aswell as ald gdb doesnt stop on instruction or stops in the middle of instruction 
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

to all concerned 
iam a noob and i had some peculiar problem 
during debugging of an assembly coded binary 

for referance you can visit and glance through this
thread in fasm board

http://board.flatassembler.net/forum.php?f=4

and googling around and ircing a bit led me to this
post in your mailing list

http://www.ussg.iu.edu/hypermail/linux/kernel/0406.3/1126.html

i actually wanted to reply to that thread so that the
questions is continous 
but i cant find out how i can reply to that thread 

i see linux torvalds himself has replied to that
thread though i dont understand much of those 
i sense it is a performance (speed issue)
but i see the behaviour in gdb due to this 
is kinda nasty (sigsegvs the binary and executes an
instruction from the middle :(

hope some one could provide some insightas to how 
i could still force a break on the test eax,eax 
and also survive without being sigsegved ??

i give the kernel version of mine atm 
uname -r
2.4.21-260-smp4G


thanks and regards

nixnoob


	
		
__________________________________ 
Yahoo! Mail - PC Magazine Editors' Choice 2005 
http://mail.yahoo.com
