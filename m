Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264754AbTBVPMF>; Sat, 22 Feb 2003 10:12:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264945AbTBVPME>; Sat, 22 Feb 2003 10:12:04 -0500
Received: from 60.54.252.64.snet.net ([64.252.54.60]:24706 "EHLO
	hotmale.blue-labs.org") by vger.kernel.org with ESMTP
	id <S264754AbTBVPME>; Sat, 22 Feb 2003 10:12:04 -0500
Message-ID: <3E5795A4.7010202@blue-labs.org>
Date: Sat, 22 Feb 2003 10:22:12 -0500
From: David Ford <david+cert@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030209
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: NFS story, update
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NFS from the Shell (2.5.59) to the web/mail server as a client (2.5.61) 
works -if- i have --no-nfs-version 3 running.  However that immediately 
broke my 2.5.61 desktop (client of web/mail) which required I reboot it.

Again, not having --no-nfs-version 3 on the shell server cause it's 
client, the web/mail server, to get root handle errors.

David

-- 
I may have the information you need and I may choose only HTML.  It's up to you. Disclaimer: I am not responsible for any email that you send me nor am I bound to any obligation to deal with any received email in any given fashion.  If you send me spam or a virus, I may in whole or part send you 50,000 return copies of it. I may also publically announce any and all emails and post them to message boards, news sites, and even parody sites.  I may also mark them up, cut and paste, print, and staple them to telephone poles for the enjoyment of people without internet access.  This is not a confidential medium and your assumption that your email can or will be handled confidentially is akin to baring your backside, burying your head in the ground, and thinking nobody can see you butt nekkid and in plain view for miles away.  Don't be a cluebert, buy one from K-mart today.

When it absolutely, positively, has to be destroyed overnight.
                           AIR FORCE


