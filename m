Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262459AbUDUNlA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262459AbUDUNlA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 09:41:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262190AbUDUNlA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 09:41:00 -0400
Received: from web61005.mail.yahoo.com ([216.155.196.94]:8322 "HELO
	web61005.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262459AbUDUNk5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 09:40:57 -0400
Message-ID: <20040421134056.61568.qmail@web61005.mail.yahoo.com>
Date: Wed, 21 Apr 2004 06:40:56 -0700 (PDT)
From: John Abraham <johnabraham291077@yahoo.com>
Subject: raidtool and 2.6 kernel (md support)
To: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       linux-rain@vger.kernel.org
Cc: johnabraham291077@yahoo.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello List
I am newbie for raid so sorry of a silly query. I have
following query regarding the raid support on linux. 
 
In linux kernel 2.6 source i have found there is
implementation of version 1 superblock (in file
drivers/md/md.c), but i have not found any raidtool,
which is using this version of superblock.
I have looked at raidtools-1.00.3 (i suppose it is
latest one, if not pls provide me latest tools which
are using version 1.0 of super block) and found that
tools are using 0.90 version of raid super block.
 
Can anybody tell me, why the newer version of raid
superblock is introduced in linux kenel 2.6 ? Any
updates regarding this would be helpful.
 
Kindly cc reply to me also as i am not member of list.
 
looking for co-operation
Thanks in Advance..
 
~John



	
		
__________________________________
Do you Yahoo!?
Yahoo! Photos: High-quality 4x6 digital prints for 25¢
http://photos.yahoo.com/ph/print_splash
