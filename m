Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262061AbTKGWmZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Nov 2003 17:42:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261801AbTKGW0T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Nov 2003 17:26:19 -0500
Received: from zeus.kernel.org ([204.152.189.113]:15062 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S264644AbTKGV7d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Nov 2003 16:59:33 -0500
Subject: [ANNOUNCE] STP Driver Model Regression Test
From: Leann Ogasawara <ogasawara@osdl.org>
To: lkml <linux-kernel@vger.kernel.org>, stp-devel@lists.sourceforge.net
Content-Type: text/plain
Message-Id: <1068241367.2675.154.camel@ibm-d.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Fri, 07 Nov 2003 13:42:48 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Just want to announce that a Driver Model Regression test has been added
to OSDL's Scalable Test Platform.

http://www.osdl.org/lab_activities/kernel_testing/stp/

The test is a series of scripts and modules built outside of the kernel
to help stress test the driver model.  An extensible amount of busses,
drivers, classes, class devices, and devices are loaded and unloaded in
parallel in an attempt to push the driver model to its limits.  The
execution time is measured and given as output upon a successful test
completion.  It is the goal of this test to detect any performance
regressions (or improvements) on previous or newly released kernels. 
Thanks so much,

Leann  

