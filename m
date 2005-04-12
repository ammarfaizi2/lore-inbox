Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261944AbVDLFVC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261944AbVDLFVC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 01:21:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262009AbVDLFTU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 01:19:20 -0400
Received: from smtp012.mail.yahoo.com ([216.136.173.32]:33129 "HELO
	smtp012.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262015AbVDLDZD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 23:25:03 -0400
Message-ID: <425B3F7A.7020501@yahoo.com>
Date: Mon, 11 Apr 2005 20:24:42 -0700
From: Alex Aizman <itn780@yahoo.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8b) Gecko/20050217
MIME-Version: 1.0
To: linux-scsi@vger.kernel.org
CC: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE 5/6] Linux-iSCSI High-Performance Initiator
Content-Type: multipart/mixed;
 boundary="------------040906020700010701040909"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040906020700010701040909
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

             include/linux/netlink.h changes (added NETLINK_ISCSI)

             Signed-off-by: Alex Aizman <itn780@yahoo.com>
             Signed-off-by: Dmitry Yusupov <dmitry_yus@yahoo.com>












--------------040906020700010701040909
Content-Type: text/plain;
 name="linux-iscsi-netlink.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-iscsi-netlink.patch"

--- linux-2.6.12-rc2.orig/include/linux/netlink.h	2005-03-01 23:38:25.000000000 -0800
+++ linux-2.6.12-rc2.dima/include/linux/netlink.h	2005-04-11 18:13:12.000000000 -0700
@@ -14,6 +14,7 @@
 #define NETLINK_SELINUX		7	/* SELinux event notifications */
 #define NETLINK_ARPD		8
 #define NETLINK_AUDIT		9	/* auditing */
+#define NETLINK_ISCSI		10	/* iSCSI Open Interface */
 #define NETLINK_ROUTE6		11	/* af_inet6 route comm channel */
 #define NETLINK_IP6_FW		13
 #define NETLINK_DNRTMSG		14	/* DECnet routing messages */



--------------040906020700010701040909--
