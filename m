Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275358AbTHGNyy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 09:54:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275359AbTHGNyx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 09:54:53 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:59871 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S275358AbTHGNyw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 09:54:52 -0400
Message-ID: <3F325A28.3010304@namesys.com>
Date: Thu, 07 Aug 2003 17:54:48 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030210
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Josef 'Jeff' Sipek" <jeffpc@optonline.net>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][TRIVIAL] Bugzilla bug # 1043 - help message for CONFIG_REISERFS_FS
 is outdated
References: <200308061642.26925.jeffpc@optonline.net>
In-Reply-To: <200308061642.26925.jeffpc@optonline.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Josef 'Jeff' Sipek wrote:

>Pretty self explanatory...The URLs should not be pointing to www.reiserfs.org since
>that has been turned into an ad site.
>
>Josef 'Jeff' Sipek
>
>--- linux-2.6.0-test2-vanilla/fs/Kconfig	2003-07-27 13:03:14.000000000 -0400
>+++ linux-2.6.0-test2-js/fs/Kconfig	2003-08-06 16:08:03.000000000 -0400
>@@ -210,7 +210,7 @@
> 
> 	  In general, ReiserFS is as fast as ext2, but is very efficient with
> 	  large directories and small files.  Additional patches are needed
>-	  for NFS and quotas, please see <http://www.reiserfs.org/> for links.
>+	  for NFS and quotas, please see <http://www.namesys.com/> for links.
> 
> 	  It is more easily extended to have features currently found in
> 	  database and keyword search systems than block allocation based file
>@@ -218,7 +218,7 @@
> 	  plugins consistent with our motto ``It takes more than a license to
> 	  make source code open.''
> 
>-	  Read <http://www.reiserfs.org/> to learn more about reiserfs.
>+	  Read <http://www.namesys.com/> to learn more about reiserfs.
> 
> 	  Sponsored by Threshold Networks, Emusic.com, and Bigstorage.com.
> 
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
>  
>
thanks.  we got cybersquatted.

-- 
Hans


