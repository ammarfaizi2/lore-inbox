Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262179AbTGAObO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 10:31:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262153AbTGAObO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 10:31:14 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:3057 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S262179AbTGAObD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 10:31:03 -0400
Message-ID: <3F019E08.40308@austin.ibm.com>
Date: Tue, 01 Jul 2003 09:43:20 -0500
From: Mark Peloquin <peloquin@austin.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>, linstab <linstab@osdl.org>,
       ltp-results <ltp-results@lists.sourceforge.net>
Subject: [BENCHMARK] 2.5.73-bk6, -bk7, -bk8, -mm2 regression test results
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Nightly Regression Summary
for
2.5.73-bk5 vs 2.5.73-bk6


Benchmark         Pass/Fail   Improvements   Regressions       Results       Results   Summary
---------------   ---------   ------------   -----------   -----------   -----------   -------

dbench.ext2           P            N              N         2.5.73-bk5    2.5.73-bk6    report
dbench.ext3           P            N              N         2.5.73-bk5    2.5.73-bk6    report
dbench.jfs            P            N              N         2.5.73-bk5    2.5.73-bk6    report
dbench.reiser         P            N              N         2.5.73-bk5    2.5.73-bk6    report
dbench.xfs            P            N              N         2.5.73-bk5    2.5.73-bk6    report
kernbench             P            N              N         2.5.73-bk5    2.5.73-bk6    report
lmbench               P            Y              Y         2.5.73-bk5    2.5.73-bk6    report
rawiobench            P            Y              Y         2.5.73-bk5    2.5.73-bk6    report
specjbb               P            Y              N         2.5.73-bk5    2.5.73-bk6    report
specsdet              P            N              Y         2.5.73-bk5    2.5.73-bk6    report
tbench                P            N              Y         2.5.73-bk5    2.5.73-bk6    report
tiobench.ext2         P            N              Y         2.5.73-bk5    2.5.73-bk6    report
tiobench.ext3         P            Y              N         2.5.73-bk5    2.5.73-bk6    report
tiobench.jfs          P            N              N         2.5.73-bk5    2.5.73-bk6    report
tiobench.reiser       P            Y              Y         2.5.73-bk5    2.5.73-bk6    report
tiobench.xfs          P            Y              N         2.5.73-bk5    2.5.73-bk6    report
volanomark            P            N              N         2.5.73-bk5    2.5.73-bk6    report

http://ltcperf.ncsa.uiuc.edu/data/2.5.73-bk6/2.5.73-bk5-vs-2.5.73-bk6/

Nightly Regression Summary
for
2.5.73 vs 2.5.73-bk6


Benchmark         Pass/Fail   Improvements   Regressions       Results       Results   Summary
---------------   ---------   ------------   -----------   -----------   -----------   -------

dbench.ext2           P            N              N             2.5.73    2.5.73-bk6    report
dbench.ext3           P            N              Y             2.5.73    2.5.73-bk6    report
dbench.jfs            P            N              N             2.5.73    2.5.73-bk6    report
dbench.reiser         P            N              N             2.5.73    2.5.73-bk6    report
dbench.xfs            P            N              N             2.5.73    2.5.73-bk6    report
kernbench             P            N              N             2.5.73    2.5.73-bk6    report
lmbench               P            Y              Y             2.5.73    2.5.73-bk6    report
rawiobench            P            Y              Y             2.5.73    2.5.73-bk6    report
specjbb               P            Y              N             2.5.73    2.5.73-bk6    report
specsdet              P            N              N             2.5.73    2.5.73-bk6    report
tbench                P            N              Y             2.5.73    2.5.73-bk6    report
tiobench.ext2         P            N              Y             2.5.73    2.5.73-bk6    report
tiobench.ext3         P            Y              Y             2.5.73    2.5.73-bk6    report
tiobench.jfs          P            N              Y             2.5.73    2.5.73-bk6    report
tiobench.reiser       P            Y              Y             2.5.73    2.5.73-bk6    report
tiobench.xfs          P            Y              Y             2.5.73    2.5.73-bk6    report
volanomark            P            N              N             2.5.73    2.5.73-bk6    report

http://ltcperf.ncsa.uiuc.edu/data/2.5.73-bk6/2.5.73-vs-2.5.73-bk6/

Nightly Regression Summary
for
2.5.73-bk6 vs 2.5.73-bk7


Benchmark         Pass/Fail   Improvements   Regressions       Results       Results   Summary
---------------   ---------   ------------   -----------   -----------   -----------   -------

dbench.ext2           P            N              N         2.5.73-bk6    2.5.73-bk7    report
dbench.ext3           P            Y              Y         2.5.73-bk6    2.5.73-bk7    report
dbench.jfs            P            N              N         2.5.73-bk6    2.5.73-bk7    report
dbench.reiser         P            N              N         2.5.73-bk6    2.5.73-bk7    report
dbench.xfs            P            N              N         2.5.73-bk6    2.5.73-bk7    report
kernbench             P            N              N         2.5.73-bk6    2.5.73-bk7    report
lmbench               P            Y              Y         2.5.73-bk6    2.5.73-bk7    report
rawiobench            P            Y              Y         2.5.73-bk6    2.5.73-bk7    report
specjbb               P            Y              Y         2.5.73-bk6    2.5.73-bk7    report
specsdet              P            N              N         2.5.73-bk6    2.5.73-bk7    report
tbench                P            Y              Y         2.5.73-bk6    2.5.73-bk7    report
tiobench.ext2         P            N              N         2.5.73-bk6    2.5.73-bk7    report
tiobench.ext3         P            N              N         2.5.73-bk6    2.5.73-bk7    report
tiobench.jfs          P            Y              N         2.5.73-bk6    2.5.73-bk7    report
tiobench.reiser       P            Y              Y         2.5.73-bk6    2.5.73-bk7    report
tiobench.xfs          P            N              Y         2.5.73-bk6    2.5.73-bk7    report
volanomark            P            N              N         2.5.73-bk6    2.5.73-bk7    report

http://ltcperf.ncsa.uiuc.edu/data/2.5.73-bk7/2.5.73-bk6-vs-2.5.73-bk7/

Nightly Regression Summary
for
2.5.73 vs 2.5.73-bk7


Benchmark         Pass/Fail   Improvements   Regressions       Results       Results   Summary
---------------   ---------   ------------   -----------   -----------   -----------   -------

dbench.ext2           P            N              N             2.5.73    2.5.73-bk7    report
dbench.ext3           P            N              N             2.5.73    2.5.73-bk7    report
dbench.jfs            P            N              N             2.5.73    2.5.73-bk7    report
dbench.reiser         P            N              N             2.5.73    2.5.73-bk7    report
dbench.xfs            P            N              N             2.5.73    2.5.73-bk7    report
kernbench             P            N              N             2.5.73    2.5.73-bk7    report
lmbench               P            Y              Y             2.5.73    2.5.73-bk7    report
rawiobench            P            Y              Y             2.5.73    2.5.73-bk7    report
specjbb               P            Y              Y             2.5.73    2.5.73-bk7    report
specsdet              P            Y              N             2.5.73    2.5.73-bk7    report
tbench                P            Y              Y             2.5.73    2.5.73-bk7    report
tiobench.ext2         P            N              Y             2.5.73    2.5.73-bk7    report
tiobench.ext3         P            Y              Y             2.5.73    2.5.73-bk7    report
tiobench.jfs          P            N              Y             2.5.73    2.5.73-bk7    report
tiobench.reiser       P            N              Y             2.5.73    2.5.73-bk7    report
tiobench.xfs          P            N              Y             2.5.73    2.5.73-bk7    report
volanomark            P            N              N             2.5.73    2.5.73-bk7    report

http://ltcperf.ncsa.uiuc.edu/data/2.5.73-bk7/2.5.73-vs-2.5.73-bk7/

Nightly Regression Summary
for
2.5.73-bk7 vs 2.5.73-bk8


Benchmark         Pass/Fail   Improvements   Regressions       Results       Results   Summary
---------------   ---------   ------------   -----------   -----------   -----------   -------

dbench.ext2           P            N              N         2.5.73-bk7    2.5.73-bk8    report
dbench.ext3           P            N              N         2.5.73-bk7    2.5.73-bk8    report
dbench.jfs            P            N              N         2.5.73-bk7    2.5.73-bk8    report
dbench.reiser         P            N              N         2.5.73-bk7    2.5.73-bk8    report
dbench.xfs            P            N              N         2.5.73-bk7    2.5.73-bk8    report
kernbench             P            N              N         2.5.73-bk7    2.5.73-bk8    report
lmbench               P            Y              Y         2.5.73-bk7    2.5.73-bk8    report
rawiobench            P            N              Y         2.5.73-bk7    2.5.73-bk8    report
specjbb               P            Y              Y         2.5.73-bk7    2.5.73-bk8    report
specsdet              P            N              N         2.5.73-bk7    2.5.73-bk8    report
tbench                P            Y              N         2.5.73-bk7    2.5.73-bk8    report
tiobench.ext2         P            N              N         2.5.73-bk7    2.5.73-bk8    report
tiobench.ext3         P            Y              N         2.5.73-bk7    2.5.73-bk8    report
tiobench.jfs          P            N              N         2.5.73-bk7    2.5.73-bk8    report
tiobench.reiser       P            N              N         2.5.73-bk7    2.5.73-bk8    report
tiobench.xfs          P            Y              N         2.5.73-bk7    2.5.73-bk8    report
volanomark            P            N              N         2.5.73-bk7    2.5.73-bk8    report

http://ltcperf.ncsa.uiuc.edu/data/2.5.73-bk8/2.5.73-bk7-vs-2.5.73-bk8/

Nightly Regression Summary
for
2.5.73 vs 2.5.73-bk8


Benchmark         Pass/Fail   Improvements   Regressions       Results       Results   Summary
---------------   ---------   ------------   -----------   -----------   -----------   -------

dbench.ext2           P            N              N             2.5.73    2.5.73-bk8    report
dbench.ext3           P            N              N             2.5.73    2.5.73-bk8    report
dbench.jfs            P            N              N             2.5.73    2.5.73-bk8    report
dbench.reiser         P            N              N             2.5.73    2.5.73-bk8    report
dbench.xfs            P            N              N             2.5.73    2.5.73-bk8    report
kernbench             P            N              N             2.5.73    2.5.73-bk8    report
lmbench               P            Y              Y             2.5.73    2.5.73-bk8    report
rawiobench            P            Y              Y             2.5.73    2.5.73-bk8    report
specjbb               P            Y              Y             2.5.73    2.5.73-bk8    report
specsdet              P            Y              N             2.5.73    2.5.73-bk8    report
tbench                P            Y              Y             2.5.73    2.5.73-bk8    report
tiobench.ext2         P            N              Y             2.5.73    2.5.73-bk8    report
tiobench.ext3         P            Y              Y             2.5.73    2.5.73-bk8    report
tiobench.jfs          P            N              Y             2.5.73    2.5.73-bk8    report
tiobench.reiser       P            N              Y             2.5.73    2.5.73-bk8    report
tiobench.xfs          P            N              Y             2.5.73    2.5.73-bk8    report
volanomark            P            N              N             2.5.73    2.5.73-bk8    report

http://ltcperf.ncsa.uiuc.edu/data/2.5.73-bk8/2.5.73-vs-2.5.73-bk8/

Nightly Regression Summary
for
2.5.73-mm1 vs 2.5.73-mm2


Benchmark         Pass/Fail   Improvements   Regressions       Results       Results   Summary
---------------   ---------   ------------   -----------   -----------   -----------   -------

dbench.ext2           P            N              N         2.5.73-mm1    2.5.73-mm2    report
dbench.ext3           P            Y              N         2.5.73-mm1    2.5.73-mm2    report
dbench.jfs            P            N              N         2.5.73-mm1    2.5.73-mm2    report
dbench.reiser         P            N              N         2.5.73-mm1    2.5.73-mm2    report
dbench.xfs            P            N              N         2.5.73-mm1    2.5.73-mm2    report
kernbench             P            N              N         2.5.73-mm1    2.5.73-mm2    report
lmbench               P            Y              Y         2.5.73-mm1    2.5.73-mm2    report
rawiobench            P            Y              Y         2.5.73-mm1    2.5.73-mm2    report
specjbb               P            Y              Y         2.5.73-mm1    2.5.73-mm2    report
specsdet              P            N              N         2.5.73-mm1    2.5.73-mm2    report
tbench                P            Y              Y         2.5.73-mm1    2.5.73-mm2    report
tiobench.ext2         P            N              N         2.5.73-mm1    2.5.73-mm2    report
tiobench.ext3         P            Y              Y         2.5.73-mm1    2.5.73-mm2    report
tiobench.jfs          P            N              Y         2.5.73-mm1    2.5.73-mm2    report
tiobench.reiser       P            N              Y         2.5.73-mm1    2.5.73-mm2    report
tiobench.xfs          P            N              Y         2.5.73-mm1    2.5.73-mm2    report
volanomark            P            N              N         2.5.73-mm1    2.5.73-mm2    report

http://ltcperf.ncsa.uiuc.edu/data/2.5.73-mm2/2.5.73-mm1-vs-2.5.73-mm2/

Nightly Regression Summary
for
2.5.73 vs 2.5.73-mm2


Benchmark         Pass/Fail   Improvements   Regressions       Results       Results   Summary
---------------   ---------   ------------   -----------   -----------   -----------   -------

dbench.ext2           P            N              N             2.5.73    2.5.73-mm2    report
dbench.ext3           P            N              N             2.5.73    2.5.73-mm2    report
dbench.jfs            P            N              N             2.5.73    2.5.73-mm2    report
dbench.reiser         P            N              N             2.5.73    2.5.73-mm2    report
dbench.xfs            P            N              N             2.5.73    2.5.73-mm2    report
kernbench             P            N              N             2.5.73    2.5.73-mm2    report
lmbench               P            Y              Y             2.5.73    2.5.73-mm2    report
rawiobench            P            Y              Y             2.5.73    2.5.73-mm2    report
specjbb               P            Y              Y             2.5.73    2.5.73-mm2    report
specsdet              P            Y              N             2.5.73    2.5.73-mm2    report
tbench                P            Y              Y             2.5.73    2.5.73-mm2    report
tiobench.ext2         P            Y              Y             2.5.73    2.5.73-mm2    report
tiobench.ext3         P            Y              Y             2.5.73    2.5.73-mm2    report
tiobench.jfs          P            Y              Y             2.5.73    2.5.73-mm2    report
tiobench.reiser       P            Y              Y             2.5.73    2.5.73-mm2    report
tiobench.xfs          P            Y              Y             2.5.73    2.5.73-mm2    report
volanomark            P            N              N             2.5.73    2.5.73-mm2    report

http://ltcperf.ncsa.uiuc.edu/data/2.5.73-mm2/2.5.73-vs-2.5.73-mm2/

Mark



