Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317582AbSIENuo>; Thu, 5 Sep 2002 09:50:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317589AbSIENuo>; Thu, 5 Sep 2002 09:50:44 -0400
Received: from ip68-14-11-228.ri.ri.cox.net ([68.14.11.228]:30030 "EHLO
	mail.blue-labs.org") by vger.kernel.org with ESMTP
	id <S317582AbSIENun>; Thu, 5 Sep 2002 09:50:43 -0400
Message-ID: <3D776238.1050805@blue-labs.org>
Date: Thu, 05 Sep 2002 09:55:04 -0400
From: David Ford <david+cert@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020824
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: kernel unable to kill processes? OOM bug
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is 2.4.20-pre5

Out of Memory: Killed process 21728 (httpd).
Out of Memory: Killed process 21728 (httpd).
Out of Memory: Killed process 21728 (httpd).
Out of Memory: Killed process 21728 (httpd).
Out of Memory: Killed process 21728 (httpd).
Out of Memory: Killed process 21728 (httpd).
Out of Memory: Killed process 21728 (httpd).
Out of Memory: Killed process 21728 (httpd).
Out of Memory: Killed process 21728 (httpd).
Out of Memory: Killed process 21728 (httpd).
Out of Memory: Killed process 21728 (httpd).
Out of Memory: Killed process 21728 (httpd).
Out of Memory: Killed process 21728 (httpd).
Out of Memory: Killed process 21728 (httpd).
Out of Memory: Killed process 21728 (httpd).
Out of Memory: Killed process 21728 (httpd).
Out of Memory: Killed process 21728 (httpd).
Out of Memory: Killed process 21728 (httpd).
Out of Memory: Killed process 21728 (httpd).
Out of Memory: Killed process 21728 (httpd).
Out of Memory: Killed process 21728 (httpd).
Out of Memory: Killed process 21728 (httpd).
Out of Memory: Killed process 21728 (httpd).
Out of Memory: Killed process 21728 (httpd).
Out of Memory: Killed process 21728 (httpd).
Out of Memory: Killed process 21728 (httpd).
Out of Memory: Killed process 21728 (httpd).
Out of Memory: Killed process 21728 (httpd).
Out of Memory: Killed process 21728 (httpd).
Out of Memory: Killed process 21728 (httpd).
Out of Memory: Killed process 21728 (httpd).
Out of Memory: Killed process 21917 (httpd).
sending pkt_too_big (len[1500] pmtu[1492]) to self
Out of Memory: Killed process 22362 (httpd).
Out of Memory: Killed process 22186 (httpd).
Out of Memory: Killed process 19465 (httpd).

(side note: why the pkt_too_big message?  eth0 is 1500 and lo is 16436)

David

-- 
I may have the information you need and I may choose only HTML.  It's up to
you. Disclaimer: I am not responsible for any email that you send me nor am
I bound to any obligation to deal with any received email in any given
fashion.  If you send me spam or a virus, I may in whole or part send you
50,000 return copies of it. I may also publically announce any and all
emails and post them to message boards, news sites, and even parody sites. 
I may also mark them up, cut and paste, print, and staple them to telephone
poles for the enjoyment of people without internet access.  This is not a
confidential medium and your assumption that your email can or will be
handled confidentially is akin to baring your backside, burying your head in
the ground, and thinking nobody can see you butt nekkid and in plain view
for miles away.  Don't be a cluebert, buy one from K-mart today.


