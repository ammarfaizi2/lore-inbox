Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932277AbVI2RZv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932277AbVI2RZv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 13:25:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932278AbVI2RZv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 13:25:51 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:15281 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S932277AbVI2RZv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 13:25:51 -0400
Message-ID: <433C23A2.9020403@namesys.com>
Date: Thu, 29 Sep 2005 10:25:54 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: ReiserFS List <reiserfs-list@namesys.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: reiser4 for 2.6.13 is available on our website
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------020108040606060707010201"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020108040606060707010201
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Reiser4 performance dropped in the -mm series due to the write
throttling patch and also dropped due to a fixed bug (removing type safe
lists added a bug).  We don't yet know if we got quite all the
performance back, we are still testing.  Conservative users should wait
a week or two to see if bug reports with reiser4 remain, or if indeed we
did get all the bugs out  of the recent cleanup patch. 

Hans

--------------020108040606060707010201
Content-Type: message/rfc822;
 name="vs's dayly report for september, 2005 (thebsh refuses ssh access)"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="vs's dayly report for september, 2005 (thebsh refuses ssh access)"

Return-Path: <vs@namesys.com>
Delivered-To: reiser@namesys.com
Received: (qmail 30334 invoked from network); 29 Sep 2005 15:11:26 -0000
Received: from ppp85-140-85-6.pppoe.mtu-net.ru (HELO ?192.168.1.10?) (85.140.85.6)
  by thebsh.namesys.com with SMTP; 29 Sep 2005 15:11:26 -0000
Message-ID: <433C0413.6080002@namesys.com>
Date: Thu, 29 Sep 2005 19:11:15 +0400
From: "Vladimir V. Saveliev" <vs@namesys.com>
Organization: Namesys
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050511
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hans Reiser <reiser@namesys.com>
Subject: vs's dayly report for september, 2005 (thebsh refuses ssh access)
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

BEG 2005.09.29:10.21 Thu
END 2005.09.29:14.11 Thu TOTAL=3:50
BEG 2005.09.29:14.40 Thu
        CHATS: preparing reiser4 patches for 2.6.13
                making sure that per-task-predictive-write-throttling-1.patch is
responsible
                for reiser4 performance drop in 2.6.14-rcX-mmY
                at least it is responsible for substantial part of it
END 2005.09.29:19.09 Thu TOTAL=4:29



--------------020108040606060707010201--
