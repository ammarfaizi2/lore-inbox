Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264650AbTF0SV3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 14:21:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264651AbTF0SV3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 14:21:29 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:5783 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S264650AbTF0SV0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 14:21:26 -0400
Message-ID: <3EFC8E3D.6050505@austin.ibm.com>
Date: Fri, 27 Jun 2003 13:34:37 -0500
From: Mark Peloquin <peloquin@austin.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>, linstab <linstab@osdl.org>,
       ltp-results <ltp-results@lists.sourceforge.net>
Subject: [BENCHMARK] 2.5.73-bk3, -bk4, -mjb1 regression test results
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Nightly Regression Summary
for
2.5.73-bk2 vs 2.5.73-bk3


Benchmark         Pass/Fail   Improvements   Regressions       Results       Results   Summary
---------------   ---------   ------------   -----------   -----------   -----------   -------

dbench.ext2           P            N              N         2.5.73-bk2    2.5.73-bk3    report
dbench.ext3           P            Y              N         2.5.73-bk2    2.5.73-bk3    report
dbench.jfs            P            N              N         2.5.73-bk2    2.5.73-bk3    report
dbench.reiser         P            N              N         2.5.73-bk2    2.5.73-bk3    report
dbench.xfs            P            N              N         2.5.73-bk2    2.5.73-bk3    report
kernbench             P            N              N         2.5.73-bk2    2.5.73-bk3    report
lmbench               P            Y              Y         2.5.73-bk2    2.5.73-bk3    report
rawiobench            P            Y              Y         2.5.73-bk2    2.5.73-bk3    report
specjbb               P            Y              N         2.5.73-bk2    2.5.73-bk3    report
specsdet              P            N              N         2.5.73-bk2    2.5.73-bk3    report
tbench                P            Y              Y         2.5.73-bk2    2.5.73-bk3    report
tiobench.ext2         P            N              N         2.5.73-bk2    2.5.73-bk3    report
tiobench.ext3         P            N              Y         2.5.73-bk2    2.5.73-bk3    report
tiobench.jfs          P            N              N         2.5.73-bk2    2.5.73-bk3    report
tiobench.reiser       P            N              Y         2.5.73-bk2    2.5.73-bk3    report
tiobench.xfs          P            N              N         2.5.73-bk2    2.5.73-bk3    report
volanomark            P            N              N         2.5.73-bk2    2.5.73-bk3    report

http://ltcperf.ncsa.uiuc.edu/data/2.5.73-bk3/2.5.73-bk2-vs-2.5.73-bk3/

Nightly Regression Summary
for
2.5.73 vs 2.5.73-bk3


Benchmark         Pass/Fail   Improvements   Regressions       Results       Results   Summary
---------------   ---------   ------------   -----------   -----------   -----------   -------

dbench.ext2           P            N              N             2.5.73    2.5.73-bk3    report
dbench.ext3           P            N              N             2.5.73    2.5.73-bk3    report
dbench.jfs            P            N              N             2.5.73    2.5.73-bk3    report
dbench.reiser         P            N              N             2.5.73    2.5.73-bk3    report
dbench.xfs            P            N              N             2.5.73    2.5.73-bk3    report
kernbench             P            N              N             2.5.73    2.5.73-bk3    report
lmbench               P            Y              Y             2.5.73    2.5.73-bk3    report
rawiobench            P            Y              Y             2.5.73    2.5.73-bk3    report
specjbb               P            Y              Y             2.5.73    2.5.73-bk3    report
specsdet              P            Y              N             2.5.73    2.5.73-bk3    report
tbench                P            N              Y             2.5.73    2.5.73-bk3    report
tiobench.ext2         P            N              N             2.5.73    2.5.73-bk3    report
tiobench.ext3         P            Y              N             2.5.73    2.5.73-bk3    report
tiobench.jfs          P            N              N             2.5.73    2.5.73-bk3    report
tiobench.reiser       P            N              N             2.5.73    2.5.73-bk3    report
tiobench.xfs          P            N              N             2.5.73    2.5.73-bk3    report
volanomark            P            N              N             2.5.73    2.5.73-bk3    report

http://ltcperf.ncsa.uiuc.edu/data/2.5.73-bk3/2.5.73-vs-2.5.73-bk3/

Nightly Regression Summary
for
2.5.73-bk3 vs 2.5.73-bk4


Benchmark         Pass/Fail   Improvements   Regressions       Results       Results   Summary
---------------   ---------   ------------   -----------   -----------   -----------   -------

dbench.ext2           P            N              N         2.5.73-bk3    2.5.73-bk4    report
dbench.ext3           P            N              Y         2.5.73-bk3    2.5.73-bk4    report
dbench.jfs            P            N              N         2.5.73-bk3    2.5.73-bk4    report
dbench.reiser         P            N              N         2.5.73-bk3    2.5.73-bk4    report
dbench.xfs            P            N              N         2.5.73-bk3    2.5.73-bk4    report
kernbench             P            N              N         2.5.73-bk3    2.5.73-bk4    report
lmbench               P            Y              Y         2.5.73-bk3    2.5.73-bk4    report
rawiobench            P            Y              Y         2.5.73-bk3    2.5.73-bk4    report
specjbb               P            N              Y         2.5.73-bk3    2.5.73-bk4    report
specsdet              P            N              N         2.5.73-bk3    2.5.73-bk4    report
tbench                P            Y              Y         2.5.73-bk3    2.5.73-bk4    report
tiobench.ext2         P            N              N         2.5.73-bk3    2.5.73-bk4    report
tiobench.ext3         P            N              Y         2.5.73-bk3    2.5.73-bk4    report
tiobench.jfs          P            N              Y         2.5.73-bk3    2.5.73-bk4    report
tiobench.reiser       P            N              Y         2.5.73-bk3    2.5.73-bk4    report
tiobench.xfs          P            N              Y         2.5.73-bk3    2.5.73-bk4    report
volanomark            P            N              N         2.5.73-bk3    2.5.73-bk4    report

http://ltcperf.ncsa.uiuc.edu/data/2.5.73-bk4/2.5.73-bk3-vs-2.5.73-bk4/

Nightly Regression Summary
for
2.5.73 vs 2.5.73-bk4


Benchmark         Pass/Fail   Improvements   Regressions       Results       Results   Summary
---------------   ---------   ------------   -----------   -----------   -----------   -------

dbench.ext2           P            N              N             2.5.73    2.5.73-bk4    report
dbench.ext3           P            N              N             2.5.73    2.5.73-bk4    report
dbench.jfs            P            N              N             2.5.73    2.5.73-bk4    report
dbench.reiser         P            N              N             2.5.73    2.5.73-bk4    report
dbench.xfs            P            N              N             2.5.73    2.5.73-bk4    report
kernbench             P            N              N             2.5.73    2.5.73-bk4    report
lmbench               P            Y              Y             2.5.73    2.5.73-bk4    report
rawiobench            P            Y              Y             2.5.73    2.5.73-bk4    report
specjbb               P            Y              Y             2.5.73    2.5.73-bk4    report
specsdet              P            Y              N             2.5.73    2.5.73-bk4    report
tbench                P            Y              Y             2.5.73    2.5.73-bk4    report
tiobench.ext2         P            N              Y             2.5.73    2.5.73-bk4    report
tiobench.ext3         P            N              Y             2.5.73    2.5.73-bk4    report
tiobench.jfs          P            N              Y             2.5.73    2.5.73-bk4    report
tiobench.reiser       P            N              Y             2.5.73    2.5.73-bk4    report
tiobench.xfs          P            N              Y             2.5.73    2.5.73-bk4    report
volanomark            P            N              N             2.5.73    2.5.73-bk4    report

http://ltcperf.ncsa.uiuc.edu/data/2.5.73-bk4/2.5.73-vs-2.5.73-bk4/

Nightly Regression Summary
for
2.5.73 vs 2.5.73-mjb1


Benchmark         Pass/Fail   Improvements   Regressions       Results       Results   Summary
---------------   ---------   ------------   -----------   -----------   -----------   -------

dbench.ext2           P            N              N             2.5.73   2.5.73-mjb1    report
dbench.ext3           P            N              Y             2.5.73   2.5.73-mjb1    report
dbench.jfs            P            N              N             2.5.73   2.5.73-mjb1    report
dbench.reiser         P            Y              N             2.5.73   2.5.73-mjb1    report
dbench.xfs            P            N              N             2.5.73   2.5.73-mjb1    report
kernbench             P            N              N             2.5.73   2.5.73-mjb1    report
lmbench               P            Y              Y             2.5.73   2.5.73-mjb1    report
rawiobench            P            Y              Y             2.5.73   2.5.73-mjb1    report
specjbb               P            N              Y             2.5.73   2.5.73-mjb1    report
specsdet              P            Y              N             2.5.73   2.5.73-mjb1    report
tbench                P            N              Y             2.5.73   2.5.73-mjb1    report
tiobench.ext2         P            Y              N             2.5.73   2.5.73-mjb1    report
tiobench.ext3         P            Y              Y             2.5.73   2.5.73-mjb1    report
tiobench.jfs          P            N              Y             2.5.73   2.5.73-mjb1    report
tiobench.reiser       P            N              N             2.5.73   2.5.73-mjb1    report
tiobench.xfs          P            Y              Y             2.5.73   2.5.73-mjb1    report
volanomark            P            N              N             2.5.73   2.5.73-mjb1    report

http://ltcperf.ncsa.uiuc.edu/data/2.5.73-mjb1/2.5.73-vs-2.5.73-mjb1/

Mark






