Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274880AbTHLAfH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 20:35:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274920AbTHLAfH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 20:35:07 -0400
Received: from imo-d01.mx.aol.com ([205.188.157.33]:51960 "EHLO
	imo-d01.mx.aol.com") by vger.kernel.org with ESMTP id S274880AbTHLAfA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 20:35:00 -0400
Date: Mon, 11 Aug 2003 20:34:49 -0400
From: A1tmblwd@netscape.net
To: linux-kernel@vger.kernel.org
Subject: [FWD: Bug in drivers/block/paride/pd.c]
MIME-Version: 1.0
Message-ID: <098FA428.01C2B229.005FFA64@netscape.net>
X-Mailer: Atlas Mailer 2.0
X-AOL-IP: 12.235.79.240
Content-Type: multipart/mixed; boundary=-------9a252301d560319a252301d56031
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


---------9a252301d560319a252301d56031
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

Hi, I sent this message to the original author; however, I am not certain that he is maintaining the code or is reachable at the address provided. Please forward to the appropriate party.

Regards,

Kam Leo

__________________________________________________________________
McAfee VirusScan Online from the Netscape Network.
Comprehensive protection for your entire computer. Get your free trial today!
http://channels.netscape.com/ns/computing/mcafee/index.jsp?promo=393397

Get AOL Instant Messenger 5.1 free of charge.  Download Now!
http://aim.aol.com/aimnew/Aim/register.adp?promo=380455

---------9a252301d560319a252301d56031
Content-Type: message/rfc822; name="Forwarded Msg"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline; filename="Forwarded Msg"
Content-Description: Forwarded Msg

Return-Path: <A1tmblwd@netscape.net>
Date: Mon, 11 Aug 2003 20:20:07 -0400
From: A1tmblwd
To: grant@torque.net
Subject: Bug in pd.c
MIME-Version: 1.0
Message-ID: <0376B263.4850C348.005FFA64@netscape.net>
X-Mailer: Atlas Mailer 2.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit


Hi, Grant.

I encountered the follwoing bug when compiling the linux-2.6.0.test3 release with patch-2.6.0.test3-bk1 applied:

drivers/block/paride/pd.c: In function `pd_init':
drivers/block/paride/pd.c:896: warning: passing arg 1 of `blk_init_queue' from incompatible pointer type
drivers/block/paride/pd.c:896: warning: passing arg 2 of `blk_init_queue' from incompatible pointer type
drivers/block/paride/pd.c:896: error: too many arguments to function `blk_init_queue'


Regards,

Kam Leo

__________________________________________________________________
McAfee VirusScan Online from the Netscape Network.
Comprehensive protection for your entire computer. Get your free trial today!
http://channels.netscape.com/ns/computing/mcafee/index.jsp?promo=393397

Get AOL Instant Messenger 5.1 free of charge.  Download Now!
http://aim.aol.com/aimnew/Aim/register.adp?promo=380455

---------9a252301d560319a252301d56031--
