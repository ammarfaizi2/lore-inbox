Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261706AbTFFOSi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 10:18:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261757AbTFFOSi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 10:18:38 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:29866 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261706AbTFFOSh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 10:18:37 -0400
Subject: Latest test runs by LTC test on 2.5.x
From: Stephanie Glass <sglass@linuxtestproject.org>
To: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 06 Jun 2003 09:34:19 -0500
Message-Id: <1054910060.968.10.camel@saglasstest.austin.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

LTC test has updated the 2.5 test runs on both the ltp and osdl site.
 
The actual pages are for the LTP site at:
http://ltp.sourceforge.net/execmatrix.php
or OSDL site at:
http://www.osdl.org/projects/26lnxstblztn/results/linstab-web/ltc/execut25_324rev1.html

We were able to run several long runs (over 96 hours) on PPC64 as well
as on IA32.  Runs were done on 2.5.70 (4), 2.5.69 (3), and 2.4.68 (1). 
Some recent examples from the matrix are:

2.5.69  Pagepoker/Apache  IBM 7026 B80, 2-way, 3GB RAM default kernel
config for PPC64 SuSE SLES 8 for PPC64 181 hours  Completed
successfully. 

2.5.69  ltp 2 instances  IBM 7026 B80, 2-way, 3GB RAM default kernel
config for PPC64 SuSE SLES 8 for PPC64 336 hours  Completed successfully
with no new errors from ltp. 

Stephanie Glass



 



