Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262027AbSIYRAp>; Wed, 25 Sep 2002 13:00:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262028AbSIYRAp>; Wed, 25 Sep 2002 13:00:45 -0400
Received: from 60.54.252.64.snet.net ([64.252.54.60]:55370 "EHLO
	mail.blue-labs.org") by vger.kernel.org with ESMTP
	id <S262027AbSIYRAp>; Wed, 25 Sep 2002 13:00:45 -0400
Message-ID: <3D91ECD9.3060808@blue-labs.org>
Date: Wed, 25 Sep 2002 13:05:29 -0400
From: David Ford <david+cert@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20020922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: sending pkt_too_big ... to self
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Bmilter: Processing completed, Bmilter version 0.1.1 build 833; timestamp 2002-09-25 13:05:45, message serial number 373144
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sending pkt_too_big (len[1500] pmtu[1492]) to self
sending pkt_too_big (len[1500] pmtu[1492]) to self
sending pkt_too_big (len[1500] pmtu[1492]) to self
sending pkt_too_big (len[1492] pmtu[1462]) to self
sending pkt_too_big (len[1492] pmtu[1462]) to self
sending pkt_too_big (len[1500] pmtu[1492]) to self
sending pkt_too_big (len[1500] pmtu[1492]) to self


What is going on here??  The lo/eth0 interfaces on this machine never 
change.

# uname -r
2.4.20-pre5

-- 
I may have the information you need and I may choose only HTML.  It's up to you. Disclaimer: I am not responsible for any email that you send me nor am I bound to any obligation to deal with any received email in any given fashion.  If you send me spam or a virus, I may in whole or part send you 50,000 return copies of it. I may also publically announce any and all emails and post them to message boards, news sites, and even parody sites.  I may also mark them up, cut and paste, print, and staple them to telephone poles for the enjoyment of people without internet access.  This is not a confidential medium and your assumption that your email can or will be handled confidentially is akin to baring your backside, burying your head in the ground, and thinking nobody can see you butt nekkid and in plain view for miles away.  Don't be a cluebert, buy one from K-mart today.


