Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264833AbTF0WAH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 18:00:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264843AbTF0WAG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 18:00:06 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:43258 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S264833AbTF0V7n
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 17:59:43 -0400
Message-ID: <3EFCC166.1060000@austin.ibm.com>
Date: Fri, 27 Jun 2003 17:12:54 -0500
From: Mark Peloquin <peloquin@austin.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>, linstab <linstab@osdl.org>,
       ltp-results <ltp-results@lists.sourceforge.net>
Subject: [BENCHMARK] 2.5.73-bk5 regression test results
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Nightly Regression Summary
for
2.5.73-bk4 vs 2.5.73-bk5


Benchmark         Pass/Fail   Improvements   Regressions       Results       Results   Summary
---------------   ---------   ------------   -----------   -----------   -----------   -------

dbench.ext2           P            N              N         2.5.73-bk4    2.5.73-bk5    report
dbench.ext3           P            N              Y         2.5.73-bk4    2.5.73-bk5    report
dbench.jfs            P            N              N         2.5.73-bk4    2.5.73-bk5    report
dbench.reiser         P            N              N         2.5.73-bk4    2.5.73-bk5    report
dbench.xfs            P            N              N         2.5.73-bk4    2.5.73-bk5    report
kernbench             P            N              N         2.5.73-bk4    2.5.73-bk5    report
lmbench               P            Y              Y         2.5.73-bk4    2.5.73-bk5    report
rawiobench            P            N              Y         2.5.73-bk4    2.5.73-bk5    report
specjbb               P            Y              Y         2.5.73-bk4    2.5.73-bk5    report
specsdet              P            Y              N         2.5.73-bk4    2.5.73-bk5    report
tbench                P            Y              Y         2.5.73-bk4    2.5.73-bk5    report
tiobench.ext2         P            N              N         2.5.73-bk4    2.5.73-bk5    report
tiobench.ext3         P            N              Y         2.5.73-bk4    2.5.73-bk5    report
tiobench.jfs          P            N              N         2.5.73-bk4    2.5.73-bk5    report
tiobench.reiser       P            Y              Y         2.5.73-bk4    2.5.73-bk5    report
tiobench.xfs          P            N              N         2.5.73-bk4    2.5.73-bk5    report
volanomark            P            N              N         2.5.73-bk4    2.5.73-bk5    report

http://ltcperf.ncsa.uiuc.edu/data/2.5.73-bk5/2.5.73-bk4-vs-2.5.73-bk5/

Nightly Regression Summary
for
2.5.73 vs 2.5.73-bk5


Benchmark         Pass/Fail   Improvements   Regressions       Results       Results   Summary
---------------   ---------   ------------   -----------   -----------   -----------   -------

dbench.ext2           P            N              N             2.5.73    2.5.73-bk5    report
dbench.ext3           P            N              Y             2.5.73    2.5.73-bk5    report
dbench.jfs            P            N              N             2.5.73    2.5.73-bk5    report
dbench.reiser         P            N              N             2.5.73    2.5.73-bk5    report
dbench.xfs            P            N              N             2.5.73    2.5.73-bk5    report
kernbench             P            N              N             2.5.73    2.5.73-bk5    report
lmbench               P            Y              Y             2.5.73    2.5.73-bk5    report
rawiobench            P            Y              Y             2.5.73    2.5.73-bk5    report
specjbb               P            Y              Y             2.5.73    2.5.73-bk5    report
specsdet              P            Y              N             2.5.73    2.5.73-bk5    report
tbench                P            N              Y             2.5.73    2.5.73-bk5    report
tiobench.ext2         P            N              Y             2.5.73    2.5.73-bk5    report
tiobench.ext3         P            N              Y             2.5.73    2.5.73-bk5    report
tiobench.jfs          P            N              Y             2.5.73    2.5.73-bk5    report
tiobench.reiser       P            Y              Y             2.5.73    2.5.73-bk5    report
tiobench.xfs          P            N              Y             2.5.73    2.5.73-bk5    report
volanomark            P            N              N             2.5.73    2.5.73-bk5    report

http://ltcperf.ncsa.uiuc.edu/data/2.5.73-bk5/2.5.73-vs-2.5.73-bk5/

Mark



