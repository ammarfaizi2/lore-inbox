Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261941AbTJXCj4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 22:39:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261943AbTJXCj4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 22:39:56 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:52106 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S261941AbTJXCjz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 22:39:55 -0400
From: jtholmesjr@comcast.net
To: linux-kernel@vger.kernel.org
Subject: 2.6Test8  scsi logging not working
Date: Fri, 24 Oct 2003 02:39:54 +0000
Message-Id: <102420030239.21121.2b7e@comcast.net>
X-Mailer: AT&T Message Center Version 1 (Oct 14 2003)
X-Authenticated-Sender: anRob2xtZXNqckBjb21jYXN0Lm5ldA==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I dont take the mail list dist just answer here in and i will see the
answer.

The problem
I thought
echo "scsi log all" >/proc/scsi/scsi 
would turn on kernel scsi logging and put some notification line
in /var/log/messages
indicating scsi logging was now active at such and such a level

that is not happening and I have a external drive connected via
usb talking scsi that cannot be unmounted and i need to trace
scsi action so I can post here.

any help would be appreciated.

jt
--
Please respond to 
jtholmes@jtholmes.com
Not to  jtholmesjr@comcast.net
