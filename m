Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262269AbTFFVGN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 17:06:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262283AbTFFVGN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 17:06:13 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:31928 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S262269AbTFFVGM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 17:06:12 -0400
Subject: Gcov-kernel patch updates for 2.4.20 and 2.5.70
From: Paul Larson <plars@linuxtestproject.org>
To: ltp-coverage@lists.sourceforge.net, lkml <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 06 Jun 2003 16:19:21 -0500
Message-Id: <1054934365.24799.59.camel@plars>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Linux Kernel GCOV patch has been updated for 2.4.20 and 2.5.70.  The
patches can be downloaded from:
https://sourceforge.net/project/showfiles.php?group_id=3382

Major changes in this release:
* ppc32 support - Many thanks to Nigel Hinds, Paul Mackerras, and
everyone else who worked on this.
* The gcov-proc module is no longer external, it can now be build with
CONFIG_GCOV_PROC turned on.  So, the tarball is no longer needed, just
the patch now.

For more information about this patch, please see:
http://ltp.sourceforge.net/coverage/gcov-kernel.php

Thanks,
Paul Larson

