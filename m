Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269776AbTGKE2a (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 00:28:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269777AbTGKE2a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 00:28:30 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:43919 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S269776AbTGKE2a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 00:28:30 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
Organization: ( )
To: LKML <linux-kernel@vger.kernel.org>
Subject: 2.5.75 does not boot - TCQ oops
Date: Thu, 10 Jul 2003 22:51:42 -0400
User-Agent: KMail/1.5.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307102251.42787.ivg2@cornell.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

See, 

http://www.ussg.iu.edu/hypermail/linux/kernel/0307.0/0515.html

where the bug is described for 2.5.74.
I got no replies, and the bug persists in 2.5.75 (+bk patches).

Note:
The machine boots with TASKFILE on, TCQ is causing the problem.



