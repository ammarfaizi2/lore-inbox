Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268522AbTBODlR>; Fri, 14 Feb 2003 22:41:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268523AbTBODlR>; Fri, 14 Feb 2003 22:41:17 -0500
Received: from ztxmail05.ztx.compaq.com ([161.114.1.209]:38923 "EHLO
	ztxmail05.ztx.compaq.com") by vger.kernel.org with ESMTP
	id <S268522AbTBODlP>; Fri, 14 Feb 2003 22:41:15 -0500
Subject: [SSI-devel] OpenSSI 0.9.0 for Linux 2.4.18
From: "Aneesh Kumar K.V" <aneesh.kumar@digital.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-TgihD0x+mG4dAqMnQy48"
X-Mailer: Ximian Evolution 1.0.8-3mdk 
Date: 15 Feb 2003 09:33:52 +0530
Message-Id: <1045281835.25638.0.camel@satan.xko.dec.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-TgihD0x+mG4dAqMnQy48
Content-Type: text/plain
Content-Transfer-Encoding: 7bit




--=-TgihD0x+mG4dAqMnQy48
Content-Disposition: inline
Content-Description: Forwarded message - [SSI-devel] OpenSSI 0.9.0 for Linux
	2.4.18
Content-Type: message/rfc822

Received: from tayexg12.americas.cpqcorp.net ([16.103.130.103]) by
	diexch01.xko.dec.com with SMTP (Microsoft Exchange Internet Mail Service
	Version 5.5.2650.21) id 1HAR8A15; Sat, 15 Feb 2003 07:21:04 +0530
Received: from zmamail01.zma.compaq.com ([161.114.72.101]) by
	tayexg12.americas.cpqcorp.net with Microsoft SMTPSVC(5.0.2195.2966); Fri,
	14 Feb 2003 20:54:05 -0500
Received: from sc8-sf-list2.sourceforge.net (lists.sourceforge.net
	[66.35.250.206]) by zmamail01.zma.compaq.com (Postfix) with ESMTP id
	09372B228; Fri, 14 Feb 2003 20:54:05 -0500 (EST)
Received: from sc8-sf-list1-b.sourceforge.net ([10.3.1.13]
	helo=sc8-sf-list1.sourceforge.net) by sc8-sf-list2.sourceforge.net with
	esmtp (Exim 3.31-VA-mm2 #1 (Debian)) id 18jrW4-0003Of-00; Fri, 14 Feb 2003
	17:53:20 -0800
Received: from zcamail03.zca.compaq.com ([161.114.32.103]) by
	sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian)) id
	18jrVh-0000CA-00; Fri, 14 Feb 2003 17:52:57 -0800
Received: from mailrelay01.cac.cpqcorp.net (mailrelay01.cac.cpqcorp.net
	[16.47.132.152]) by zcamail03.zca.compaq.com (Postfix) with ESMTP id
	05BCB174B; Fri, 14 Feb 2003 17:52:52 -0800 (PST)
Received: from kahuna.lax.cpqcorp.net (kahuna.lax.cpqcorp.net
	[16.61.166.23]) by mailrelay01.cac.cpqcorp.net (Postfix) with ESMTP id
	0C92C2785; Fri, 14 Feb 2003 17:52:51 -0800 (PST)
Received: from hp.com ([16.47.225.129]) by kahuna.lax.cpqcorp.net
	(8.10.1/UW7.1.1-NSCd) with ESMTP id h1F1qob16274; Fri, 14 Feb 2003 17:52:50
	-0800 (PST)
Message-ID: <3E4D9CFD.E9FAFC0E@hp.com>
From: "Brian J. Watson" <Brian.J.Watson@hp.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: SSI users <ssic-linux-users@lists.sourceforge.net>, SSI developers <ssic-linux-devel@lists.sourceforge.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: [SSI-devel] OpenSSI 0.9.0 for Linux 2.4.18
Sender: ssic-linux-devel-admin@lists.sourceforge.net
Errors-To: ssic-linux-devel-admin@lists.sourceforge.net
X-BeenThere: ssic-linux-devel@lists.sourceforge.net
X-Mailman-Version: 2.0.9-sf.net
Precedence: bulk
List-Help: 	<mailto:ssic-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:ssic-linux-devel@lists.sourceforge.net>
List-Subscribe: 	<https://lists.sourceforge.net/lists/listinfo/ssic-linux-devel>,
	<mailto:ssic-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: Developer discussion <ssic-linux-devel.lists.sourceforge.net>
List-Unsubscribe: 	<https://lists.sourceforge.net/lists/listinfo/ssic-linux-devel>,
	<mailto:ssic-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: 	<http://sourceforge.net/mailarchive/forum.php?forum=ssic-linux-devel>
X-Original-Date: Fri, 14 Feb 2003 17:50:53 -0800
Date: Fri, 14 Feb 2003 17:50:53 -0800
Return-Path: ssic-linux-devel-admin@lists.sourceforge.net
X-OriginalArrivalTime: 15 Feb 2003 01:54:05.0724 (UTC)
	FILETIME=[1F2095C0:01C2D495]

OpenSSI has been tested up to 27 IA-64 nodes and 41 IA-32 nodes. It
includes a first cut of being able to failover a hard mounted CFS root
filesystem. /dev is now a context symlink into devfs. Semaphores and
Unix domain datagram sockets are now clusterwide.  The Lustre client has
been integrated for non-root filesystems. A /proc interface is now used
to migrate a process, rather than sending it a special signal. Various
bugs have been fixed, including problems with strace on IA64 and Alpha.

Note that you should build you ramdisk with the --nosync option to
cluster_mkinitrd. The automatic syncing feature appears to be broken.

You can get the OpenSSI 0.9.0 source code at OpenSSI.org. I'll roll the
binary RPMs on Monday.

-- 
Brian Watson
OpenSSI Clustering project
OpenSSI.org


-------------------------------------------------------
This SF.NET email is sponsored by: FREE  SSL Guide from Thawte
are you planning your Web Server Security? Click here to get a FREE
Thawte SSL guide and find the answers to all your  SSL security issues.
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0026en
_______________________________________________
ssic-linux-devel mailing list
ssic-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ssic-linux-devel

--=-TgihD0x+mG4dAqMnQy48--

