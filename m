Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316675AbSGZARy>; Thu, 25 Jul 2002 20:17:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316678AbSGZARy>; Thu, 25 Jul 2002 20:17:54 -0400
Received: from air-2.osdl.org ([65.172.181.6]:54438 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S316675AbSGZARy>;
	Thu, 25 Jul 2002 20:17:54 -0400
Subject: [ANNOUNCE] [OSDL] Database Performance Numbers Posted on OSDL
From: Craig Thomas <craiger@osdl.org>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 25 Jul 2002 17:21:08 -0700
Message-Id: <1027642868.2492.3.camel@bullpen>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OSDL has created a database workload that simulates an e-commerce book
store.  The back end of the database is SAP.  We have posted performance
statistics on the following web site:

      http://www.osdl.org/projects/dbt1prfrns/results

The table will eventually grow as more kernels are tested on different
systems.  Currently we have performance characteristics for a 2-way
system, 1 GB memory, utilizing 10 disk spindles for its database.  The
other performance measurements are conducted on a 8-way system, 16 GB
memory, utilizing 12 disk spindles for its database.  These runs involve
the same number of users accessing the database.

In addition to capturing database transaction numbers, data is captured
for I/O, memory usage, and CPU utilization.  Currently, the performance
work is being  conducted on 2.4 kernels.

However, STP is running a smaller version of this test on 2.5 kernels. 
The first results from this run is located at

    http://khack.osdlab.org/stp/3441/

Is there any other kinds of information that would be useful to capture
and post?

-- 
Craig Thomas                         phone: 503-626-2455  ext. 33
Open Source Development Labs         email: craiger@osdl.org

