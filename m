Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317463AbSF1RAu>; Fri, 28 Jun 2002 13:00:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317464AbSF1RAu>; Fri, 28 Jun 2002 13:00:50 -0400
Received: from ip68-9-71-221.ri.ri.cox.net ([68.9.71.221]:31570 "EHLO
	mailhub.blue-labs.org") by vger.kernel.org with ESMTP
	id <S317463AbSF1RAt>; Fri, 28 Jun 2002 13:00:49 -0400
Message-ID: <3D1C96C3.9000500@blue-labs.org>
Date: Fri, 28 Jun 2002 13:02:59 -0400
From: David Ford <david+cert@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1a+) Gecko/20020622
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: broken flock()
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Bmilter: Processing completed, Bmilter version 0.1.0 build 758; timestamp 2002-06-28 13:03:09, message serial number 66993
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From http://sendmail.org/

NOTE: Linux appears to have broken flock() again.  Unless
	the bug is fixed before sendmail 8.13 is shipped,
	8.13 will change the default locking method to
	fcntl() for Linux kernel 2.4 and later.  You may
	want to do this in 8.12 by compiling with
	-DHASFLOCK=0.  Be sure to update other sendmail
	related programs to match locking techniques.

Is it really broken or is sendmail smoking crack like when they said that itimers in Linux didn't work?

David



