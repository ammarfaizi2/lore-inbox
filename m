Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263806AbUBRJYm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 04:24:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263868AbUBRJYm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 04:24:42 -0500
Received: from inet-mail1.oracle.com ([148.87.2.201]:16596 "EHLO
	inet-mail1.oracle.com") by vger.kernel.org with ESMTP
	id S263806AbUBRJYk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 04:24:40 -0500
Message-ID: <40332F42.9070605@iitbombay.org>
Date: Wed, 18 Feb 2004 14:54:18 +0530
From: Niraj Kumar <niraj17@iitbombay.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: akpm@osdl.org
Subject: [PATCH] [2.6]  UFS2 Read Only Patch 
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

Please  apply this patch .
They provide the bare minimum read-only support for
ufs2 variant (from FreeBSD 5.x ) of the UFS filesystem .

The patch for 2.6.3 is here :
http://ufs-linux.sourceforge.net/ufs2/2.6.3/ufs2-read-only-p1.txt
http://ufs-linux.sourceforge.net/ufs2/2.6.3/ufs2-read-only-p2.txt

Thanks
Niraj


 >Hi ,
 >
 >I am trying to produce some patches to be able to
 >support UFS2 (of FreeBSD 5.x )  filesystem.
 >
 >The work-in-progress patches are available from
 >http://ufs-linux.sourceforge.net/ufs2/p1.txt
 > http://ufs-linux.sourceforge.net/ufs2/p2.txt
 >
 >Currently , these provides the bare minimum  ufs2
 >support and that also for Read-Only .
 >
 >This is just a snapshot so several things simply may not work.
 >But atleast I was able to mount my ufs2 partition
 >(from a FreeBSD 5.2 install ) and read files.
 >
 >Some testing will be good on them, though.
 >
 >Niraj


