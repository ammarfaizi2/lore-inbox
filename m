Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292325AbSBYWXp>; Mon, 25 Feb 2002 17:23:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292350AbSBYWXd>; Mon, 25 Feb 2002 17:23:33 -0500
Received: from fe090.worldonline.dk ([212.54.64.152]:26639 "HELO
	fe090.worldonline.dk") by vger.kernel.org with SMTP
	id <S292352AbSBYWXK>; Mon, 25 Feb 2002 17:23:10 -0500
Message-ID: <3C7AB9D5.9080906@dif.dk>
Date: Mon, 25 Feb 2002 23:25:25 +0100
From: Jesper Juhl <jju@dif.dk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011126 Netscape6/6.2.1
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4.18 - the missing patch issue
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, so 2.4.18 was released without a fix that onyl matters to a very 
limited number of Linux users, while that's not perfect it's not the end 
of the world either.

A few different solutions have been suggested :

1) People have suggested releasing a new 2.4.18 emidiately which 
includes the missing fix.
2) Someone proposed to release 2.4.19 imidiately which would be 2.4.18 + 
the missing fix.
3) Some people just want to forget about it ;)

All 3 are IMVHO bad ideas for these reasons; nr. 1 would create 
confusion by having two different versions of 2.4.18 floating around. 
nr. 2 would probably also cause some minor degree of confusion amongst 
users and would also give the (wrong) impression that Linux kernel 
releases are not thoroughly tested. I'll not comment on 3 ;)

I suggest that instead of the previously proposed solutions an effort 
should instead be made to release 2.4.19 relatively fast. Instead of 
including a lot of fixes, only include the most critical known fixes in 
2.4.19-pre1 (and maybe -pre2), then go to -rc1 as soon as possible and 
get 2.4.19 out the door pretty fast with important fixes and leave all 
other stuff for 2.4.20-pre1


Just my 0.02 euro-cent


- Jesper Juhl - jju@dif.dk -


