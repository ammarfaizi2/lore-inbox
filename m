Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280904AbRKOP3P>; Thu, 15 Nov 2001 10:29:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280911AbRKOP3F>; Thu, 15 Nov 2001 10:29:05 -0500
Received: from jackie.iddl.vt.edu ([128.173.53.192]:18091 "EHLO
	jackie.iddl.vt.edu") by vger.kernel.org with ESMTP
	id <S280904AbRKOP2v>; Thu, 15 Nov 2001 10:28:51 -0500
Message-ID: <3BF3DF31.4010707@vt.edu>
Date: Thu, 15 Nov 2001 10:28:49 -0500
From: Jackie Meese <jackie.m@vt.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 32 Groups Maximum in 2.4
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm not subscribed, so please cc: me on any replies.

I've been looking for some time on how to raise the maximum number of 
groups for the 2.4 kernel.  I've discovered how to do this kernel, with 
a discussion a few months ago on this 
list.http://www.cs.helsinki.fi/linux/linux-kernel/2001-13/0807.html

However the follow up of "You gotta change the task struct..." means 
nothing to me.

Can someone be more specific as to the changes that need to be made to 
accomplish this?  Change the task struct where?  I can find lots of 
references to task_struct in the sources simply by grepping them, but I 
can't since any that point to a 32 limit.  I'm not a kernel hacker, but 
I've read and edited a fair bit of source code in my time, so I thik I 
just need a bit more of a clue in here.

TIA,
j.
-- 
Jackie Meese	Institute for Distance and Distributed Learning, Va Tech
Phone: 231-3682	3027 Torgersen Hall MailCode:0445 http://www.iddl.vt.edu/
Education is the change in behavior that occurs as the result of
interaction with events in ones environment.

