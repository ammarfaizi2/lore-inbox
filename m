Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262714AbTFJNr2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 09:47:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262497AbTFJNr2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 09:47:28 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:48597 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S262714AbTFJNrJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 09:47:09 -0400
Message-ID: <3EE5E449.7010400@austin.ibm.com>
Date: Tue, 10 Jun 2003 08:59:37 -0500
From: Mark Peloquin <peloquin@austin.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>, linstab <linstab@osdl.org>,
       ltp-results <ltp-results@lists.sourceforge.net>
Subject: [BENCHMARK] bk11-14, mm6 regression results
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As requested, we're currently including the summaries in this email. Feel free to comment if you like this or not.


Nightly Regression Summary
for
2.5.70 vs 2.5.70-bk11


Benchmark         Pass/Fail   Improvements   Regressions       Results       Results   Summary
---------------   ---------   ------------   -----------   -----------   -----------   -------

dbench.ext2           P            Y              N             2.5.70   2.5.70-bk11    report
dbench.ext3           P            N              N             2.5.70   2.5.70-bk11    report
dbench.jfs            P            N              N             2.5.70   2.5.70-bk11    report
dbench.reiser         P            N              N             2.5.70   2.5.70-bk11    report
dbench.xfs            P            N              N             2.5.70   2.5.70-bk11    report
kernbench             P            N              N             2.5.70   2.5.70-bk11    report
lmbench               P            Y              Y             2.5.70   2.5.70-bk11    report
rawiobench            P            Y              N             2.5.70   2.5.70-bk11    report
specjbb               P            Y              Y             2.5.70   2.5.70-bk11    report
specsdet              P            N              N             2.5.70   2.5.70-bk11    report
tbench                P            Y              Y             2.5.70   2.5.70-bk11    report
tiobench.ext2         P            N              N             2.5.70   2.5.70-bk11    report
tiobench.ext3         P            N              Y             2.5.70   2.5.70-bk11    report
tiobench.jfs          P            N              N             2.5.70   2.5.70-bk11    report
tiobench.reiser       P            Y              Y             2.5.70   2.5.70-bk11    report
tiobench.xfs          P            Y              N             2.5.70   2.5.70-bk11    report
volanomark            P            N              N             2.5.70   2.5.70-bk11    report

http://www-124.ibm.com/developerworks/oss/linuxperf/regression/2.5.70-bk11/2.5.70-vs-2.5.70-bk11/

Nightly Regression Summary
for
2.5.70-bk10 vs 2.5.70-bk11


Benchmark         Pass/Fail   Improvements   Regressions       Results       Results   Summary
---------------   ---------   ------------   -----------   -----------   -----------   -------

dbench.ext2           P            N              N        2.5.70-bk10   2.5.70-bk11    report
dbench.ext3           P            Y              N        2.5.70-bk10   2.5.70-bk11    report
dbench.jfs            P            N              N        2.5.70-bk10   2.5.70-bk11    report
dbench.reiser         P            N              N        2.5.70-bk10   2.5.70-bk11    report
dbench.xfs            P            N              N        2.5.70-bk10   2.5.70-bk11    report
kernbench             P            N              N        2.5.70-bk10   2.5.70-bk11    report
lmbench               P            Y              Y        2.5.70-bk10   2.5.70-bk11    report
rawiobench            P            Y              N        2.5.70-bk10   2.5.70-bk11    report
specjbb               P            N              Y        2.5.70-bk10   2.5.70-bk11    report
specsdet              P            N              N        2.5.70-bk10   2.5.70-bk11    report
tbench                P            Y              Y        2.5.70-bk10   2.5.70-bk11    report
tiobench.ext2         P            N              N        2.5.70-bk10   2.5.70-bk11    report
tiobench.ext3         P            Y              N        2.5.70-bk10   2.5.70-bk11    report
tiobench.jfs          P            N              N        2.5.70-bk10   2.5.70-bk11    report
tiobench.reiser       P            Y              Y        2.5.70-bk10   2.5.70-bk11    report
tiobench.xfs          P            N              N        2.5.70-bk10   2.5.70-bk11    report
volanomark            P            N              N        2.5.70-bk10   2.5.70-bk11    report

http://www-124.ibm.com/developerworks/oss/linuxperf/regression/2.5.70-bk11/2.5.70-bk10-vs-2.5.70-bk11/

Nightly Regression Summary
for
2.5.70 vs 2.5.70-bk12


Benchmark         Pass/Fail   Improvements   Regressions       Results       Results   Summary
---------------   ---------   ------------   -----------   -----------   -----------   -------

dbench.ext2           P            Y              N             2.5.70   2.5.70-bk12    report
dbench.ext3           P            N              Y             2.5.70   2.5.70-bk12    report
dbench.jfs            P            N              N             2.5.70   2.5.70-bk12    report
dbench.reiser         P            N              N             2.5.70   2.5.70-bk12    report
dbench.xfs            P            N              N             2.5.70   2.5.70-bk12    report
kernbench             P            N              N             2.5.70   2.5.70-bk12    report
lmbench               P            Y              Y             2.5.70   2.5.70-bk12    report
rawiobench            P            Y              N             2.5.70   2.5.70-bk12    report
specjbb               P            Y              Y             2.5.70   2.5.70-bk12    report
specsdet              P            N              Y             2.5.70   2.5.70-bk12    report
tbench                P            N              Y             2.5.70   2.5.70-bk12    report
tiobench.ext2         P            Y              N             2.5.70   2.5.70-bk12    report
tiobench.ext3         P            Y              Y             2.5.70   2.5.70-bk12    report
tiobench.jfs          P            N              N             2.5.70   2.5.70-bk12    report
tiobench.reiser       P            Y              Y             2.5.70   2.5.70-bk12    report
tiobench.xfs          P            N              N             2.5.70   2.5.70-bk12    report
volanomark            P            N              N             2.5.70   2.5.70-bk12    report

http://www-124.ibm.com/developerworks/oss/linuxperf/regression/2.5.70-bk12/2.5.70-vs-2.5.70-bk12/

Nightly Regression Summary
for
2.5.70-bk11 vs 2.5.70-bk12


Benchmark         Pass/Fail   Improvements   Regressions       Results       Results   Summary
---------------   ---------   ------------   -----------   -----------   -----------   -------

dbench.ext2           P            N              N        2.5.70-bk11   2.5.70-bk12    report
dbench.ext3           P            N              Y        2.5.70-bk11   2.5.70-bk12    report
dbench.jfs            P            N              N        2.5.70-bk11   2.5.70-bk12    report
dbench.reiser         P            N              N        2.5.70-bk11   2.5.70-bk12    report
dbench.xfs            P            N              N        2.5.70-bk11   2.5.70-bk12    report
kernbench             P            N              N        2.5.70-bk11   2.5.70-bk12    report
lmbench               P            Y              Y        2.5.70-bk11   2.5.70-bk12    report
rawiobench            P            N              N        2.5.70-bk11   2.5.70-bk12    report
specjbb               P            Y              N        2.5.70-bk11   2.5.70-bk12    report
specsdet              P            N              Y        2.5.70-bk11   2.5.70-bk12    report
tbench                P            Y              Y        2.5.70-bk11   2.5.70-bk12    report
tiobench.ext2         P            N              N        2.5.70-bk11   2.5.70-bk12    report
tiobench.ext3         P            Y              N        2.5.70-bk11   2.5.70-bk12    report
tiobench.jfs          P            N              N        2.5.70-bk11   2.5.70-bk12    report
tiobench.reiser       P            Y              Y        2.5.70-bk11   2.5.70-bk12    report
tiobench.xfs          P            N              N        2.5.70-bk11   2.5.70-bk12    report
volanomark            P            N              N        2.5.70-bk11   2.5.70-bk12    report

http://www-124.ibm.com/developerworks/oss/linuxperf/regression/2.5.70-bk12/2.5.70-bk11-vs-2.5.70-bk12/

Nightly Regression Summary
for
2.5.70 vs 2.5.70-bk13


Benchmark         Pass/Fail   Improvements   Regressions       Results       Results   Summary
---------------   ---------   ------------   -----------   -----------   -----------   -------

dbench.ext2           P            Y              N             2.5.70   2.5.70-bk13    report
dbench.ext3           P            N              N             2.5.70   2.5.70-bk13    report
dbench.jfs            P            N              N             2.5.70   2.5.70-bk13    report
dbench.reiser         P            N              N             2.5.70   2.5.70-bk13    report
dbench.xfs            P            N              N             2.5.70   2.5.70-bk13    report
kernbench             P            N              N             2.5.70   2.5.70-bk13    report
lmbench               P            Y              Y             2.5.70   2.5.70-bk13    report
rawiobench            P            Y              Y             2.5.70   2.5.70-bk13    report
specjbb               P            Y              Y             2.5.70   2.5.70-bk13    report
specsdet              P            N              Y             2.5.70   2.5.70-bk13    report
tbench                P            Y              N             2.5.70   2.5.70-bk13    report
tiobench.ext2         P            N              N             2.5.70   2.5.70-bk13    report
tiobench.ext3         P            N              Y             2.5.70   2.5.70-bk13    report
tiobench.jfs          P            N              N             2.5.70   2.5.70-bk13    report
tiobench.reiser       P            Y              Y             2.5.70   2.5.70-bk13    report
tiobench.xfs          P            N              N             2.5.70   2.5.70-bk13    report
volanomark            P            N              N             2.5.70   2.5.70-bk13    report

http://www-124.ibm.com/developerworks/oss/linuxperf/regression/2.5.70-bk13/2.5.70-vs-2.5.70-bk13/

Nightly Regression Summary
for
2.5.70-bk12 vs 2.5.70-bk13


Benchmark         Pass/Fail   Improvements   Regressions       Results       Results   Summary
---------------   ---------   ------------   -----------   -----------   -----------   -------

dbench.ext2           P            N              N        2.5.70-bk12   2.5.70-bk13    report
dbench.ext3           P            Y              Y        2.5.70-bk12   2.5.70-bk13    report
dbench.jfs            P            N              N        2.5.70-bk12   2.5.70-bk13    report
dbench.reiser         P            N              N        2.5.70-bk12   2.5.70-bk13    report
dbench.xfs            P            N              N        2.5.70-bk12   2.5.70-bk13    report
kernbench             P            N              N        2.5.70-bk12   2.5.70-bk13    report
lmbench               P            Y              Y        2.5.70-bk12   2.5.70-bk13    report
rawiobench            P            N              Y        2.5.70-bk12   2.5.70-bk13    report
specjbb               P            N              Y        2.5.70-bk12   2.5.70-bk13    report
specsdet              P            Y              N        2.5.70-bk12   2.5.70-bk13    report
tbench                P            Y              N        2.5.70-bk12   2.5.70-bk13    report
tiobench.ext2         P            N              Y        2.5.70-bk12   2.5.70-bk13    report
tiobench.ext3         P            N              Y        2.5.70-bk12   2.5.70-bk13    report
tiobench.jfs          P            N              N        2.5.70-bk12   2.5.70-bk13    report
tiobench.reiser       P            Y              Y        2.5.70-bk12   2.5.70-bk13    report
tiobench.xfs          P            N              N        2.5.70-bk12   2.5.70-bk13    report
volanomark            P            N              N        2.5.70-bk12   2.5.70-bk13    report

http://www-124.ibm.com/developerworks/oss/linuxperf/regression/2.5.70-bk13/2.5.70-bk12-vs-2.5.70-bk13/

Nightly Regression Summary
for
2.5.70 vs 2.5.70-bk14


Benchmark         Pass/Fail   Improvements   Regressions       Results       Results   Summary
---------------   ---------   ------------   -----------   -----------   -----------   -------

dbench.ext2           P            Y              N             2.5.70   2.5.70-bk14    report
dbench.ext3           P            Y              N             2.5.70   2.5.70-bk14    report
dbench.jfs            P            N              N             2.5.70   2.5.70-bk14    report
dbench.reiser         P            N              N             2.5.70   2.5.70-bk14    report
dbench.xfs            P            N              N             2.5.70   2.5.70-bk14    report
kernbench             P            N              N             2.5.70   2.5.70-bk14    report
lmbench               P            Y              Y             2.5.70   2.5.70-bk14    report
rawiobench            P            Y              Y             2.5.70   2.5.70-bk14    report
specjbb               P            Y              Y             2.5.70   2.5.70-bk14    report
specsdet              P            N              N             2.5.70   2.5.70-bk14    report
tbench                P            Y              Y             2.5.70   2.5.70-bk14    report
tiobench.ext2         P            N              N             2.5.70   2.5.70-bk14    report
tiobench.ext3         P            Y              Y             2.5.70   2.5.70-bk14    report
tiobench.jfs          P            N              N             2.5.70   2.5.70-bk14    report
tiobench.reiser       P            Y              Y             2.5.70   2.5.70-bk14    report
tiobench.xfs          P            Y              N             2.5.70   2.5.70-bk14    report
volanomark            P            N              N             2.5.70   2.5.70-bk14    report

http://www-124.ibm.com/developerworks/oss/linuxperf/regression/2.5.70-bk14/2.5.70-vs-2.5.70-bk14/

Nightly Regression Summary
for
2.5.70-bk13 vs 2.5.70-bk14


Benchmark         Pass/Fail   Improvements   Regressions       Results       Results   Summary
---------------   ---------   ------------   -----------   -----------   -----------   -------

dbench.ext2           P            N              N        2.5.70-bk13   2.5.70-bk14    report
dbench.ext3           P            Y              Y        2.5.70-bk13   2.5.70-bk14    report
dbench.jfs            P            N              N        2.5.70-bk13   2.5.70-bk14    report
dbench.reiser         P            N              N        2.5.70-bk13   2.5.70-bk14    report
dbench.xfs            P            N              N        2.5.70-bk13   2.5.70-bk14    report
kernbench             P            N              N        2.5.70-bk13   2.5.70-bk14    report
lmbench               P            Y              Y        2.5.70-bk13   2.5.70-bk14    report
rawiobench            P            N              N        2.5.70-bk13   2.5.70-bk14    report
specjbb               P            Y              N        2.5.70-bk13   2.5.70-bk14    report
specsdet              P            N              N        2.5.70-bk13   2.5.70-bk14    report
tbench                P            N              Y        2.5.70-bk13   2.5.70-bk14    report
tiobench.ext2         P            N              N        2.5.70-bk13   2.5.70-bk14    report
tiobench.ext3         P            Y              Y        2.5.70-bk13   2.5.70-bk14    report
tiobench.jfs          P            N              N        2.5.70-bk13   2.5.70-bk14    report
tiobench.reiser       P            Y              Y        2.5.70-bk13   2.5.70-bk14    report
tiobench.xfs          P            N              N        2.5.70-bk13   2.5.70-bk14    report
volanomark            P            N              N        2.5.70-bk13   2.5.70-bk14    report

http://www-124.ibm.com/developerworks/oss/linuxperf/regression/2.5.70-bk14/2.5.70-bk13-vs-2.5.70-bk14/

Nightly Regression Summary
for
2.5.70 vs 2.5.70-mm6


Benchmark         Pass/Fail   Improvements   Regressions       Results       Results   Summary
---------------   ---------   ------------   -----------   -----------   -----------   -------

dbench.ext2           P            Y              N             2.5.70    2.5.70-mm6    report
dbench.ext3           P            Y              N             2.5.70    2.5.70-mm6    report
dbench.jfs            P            N              N             2.5.70    2.5.70-mm6    report
dbench.reiser         P            Y              N             2.5.70    2.5.70-mm6    report
dbench.xfs            P            N              N             2.5.70    2.5.70-mm6    report
kernbench             P            N              N             2.5.70    2.5.70-mm6    report
lmbench               P            Y              Y             2.5.70    2.5.70-mm6    report
rawiobench            P            Y              Y             2.5.70    2.5.70-mm6    report
specjbb               P            Y              Y             2.5.70    2.5.70-mm6    report
specsdet              P            N              Y             2.5.70    2.5.70-mm6    report
tbench                P            Y              Y             2.5.70    2.5.70-mm6    report
tiobench.ext2         P            Y              Y             2.5.70    2.5.70-mm6    report
tiobench.ext3         P            Y              Y             2.5.70    2.5.70-mm6    report
tiobench.jfs          P            Y              Y             2.5.70    2.5.70-mm6    report
tiobench.reiser       P            Y              Y             2.5.70    2.5.70-mm6    report
tiobench.xfs          P            Y              Y             2.5.70    2.5.70-mm6    report
volanomark            P            N              N             2.5.70    2.5.70-mm6    report

http://www-124.ibm.com/developerworks/oss/linuxperf/regression/2.5.70-mm6/2.5.70-vs-2.5.70-mm6/

Nightly Regression Summary
for
2.5.70-mm5 vs 2.5.70-mm6


Benchmark         Pass/Fail   Improvements   Regressions       Results       Results   Summary
---------------   ---------   ------------   -----------   -----------   -----------   -------

dbench.ext2           P            N              N         2.5.70-mm5    2.5.70-mm6    report
dbench.ext3           P            N              Y         2.5.70-mm5    2.5.70-mm6    report
dbench.jfs            P            N              N         2.5.70-mm5    2.5.70-mm6    report
dbench.reiser         P            Y              N         2.5.70-mm5    2.5.70-mm6    report
dbench.xfs            P            N              N         2.5.70-mm5    2.5.70-mm6    report
kernbench             P            N              N         2.5.70-mm5    2.5.70-mm6    report
lmbench               P            Y              Y         2.5.70-mm5    2.5.70-mm6    report
rawiobench            P            Y              N         2.5.70-mm5    2.5.70-mm6    report
specjbb               P            Y              Y         2.5.70-mm5    2.5.70-mm6    report
specsdet              P            Y              N         2.5.70-mm5    2.5.70-mm6    report
tbench                P            Y              N         2.5.70-mm5    2.5.70-mm6    report
tiobench.ext2         P            Y              N         2.5.70-mm5    2.5.70-mm6    report
tiobench.ext3         P            Y              Y         2.5.70-mm5    2.5.70-mm6    report
tiobench.jfs          P            Y              Y         2.5.70-mm5    2.5.70-mm6    report
tiobench.reiser       P            Y              Y         2.5.70-mm5    2.5.70-mm6    report
tiobench.xfs          P            Y              Y         2.5.70-mm5    2.5.70-mm6    report
volanomark            P            Y              N         2.5.70-mm5    2.5.70-mm6    report

http://www-124.ibm.com/developerworks/oss/linuxperf/regression/2.5.70-mm6/2.5.70-mm5-vs-2.5.70-mm6/


