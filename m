Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264000AbUCZKdl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 05:33:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264004AbUCZKdl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 05:33:41 -0500
Received: from green.mif.pg.gda.pl ([153.19.42.8]:36679 "EHLO
	green.mif.pg.gda.pl") by vger.kernel.org with ESMTP id S264002AbUCZKdj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 05:33:39 -0500
From: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>
Message-Id: <200403261033.i2QAXgii022013@green.mif.pg.gda.pl>
Subject: [2.4] disapearing routing entries
To: linux-kernel@vger.kernel.org (kernel list)
Date: Fri, 26 Mar 2004 11:33:42 +0100 (CET)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I sometimes notice while using different 2.4/2.2 kernels that some static
route entries tend to disappear suddenly few days after they are manually
added. It happens only to manually added (non-automatic) entries.
No messages concerning this are found in dmesg and system logs.

This happens to me on different kernels (2.4 up to 2.4.25, and also on
2.2.25), on different architectures (i386, sparc), on different routing
tables (default and an extra one, No. 100), after different (but random)
amount of time (few to over 30 days), etc.

In all cases always specific routing entries seem to disappear (not all, and
always the same in a specific routing configuration).

Could anybody tell me:

1. Whether the problem is known?
2. How to further debug this problem?


Andrzej

-- 
=======================================================================
  Andrzej M. Krzysztofowicz               ankry@mif.pg.gda.pl
  phone (48)(58) 347 14 61
Faculty of Applied Phys. & Math.,   Gdansk University of Technology
