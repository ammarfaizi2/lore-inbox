Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265702AbTFSB4A (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 21:56:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265703AbTFSB4A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 21:56:00 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:58353 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S265702AbTFSBz4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 21:55:56 -0400
Message-ID: <3EF11ACF.4040503@austin.ibm.com>
Date: Wed, 18 Jun 2003 21:07:11 -0500
From: Mark Peloquin <peloquin@austin.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>, linstab <linstab@osdl.org>,
       ltp-results <ltp-results@lists.sourceforge.net>
Subject: BENCHMARK] 2.5.72, 2.5.72-mm1, 2.5.71, 2.5.71-bk1, 2.5.71-mjb1
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Nightly Regression Summary
for
2.5.72 vs 2.5.72-mm1


Benchmark         Pass/Fail   Improvements   Regressions       Results       Results   Summary
---------------   ---------   ------------   -----------   -----------   -----------   -------

dbench.ext2           P            N              N             2.5.72    2.5.72-mm1    report
dbench.ext3           P            Y              N             2.5.72    2.5.72-mm1    report
dbench.jfs            P            N              N             2.5.72    2.5.72-mm1    report
dbench.reiser         P            Y              N             2.5.72    2.5.72-mm1    report
dbench.xfs            P            N              N             2.5.72    2.5.72-mm1    report
kernbench             P            N              N             2.5.72    2.5.72-mm1    report
lmbench               P            Y              Y             2.5.72    2.5.72-mm1    report
rawiobench            P            Y              Y             2.5.72    2.5.72-mm1    report
specjbb               P            Y              Y             2.5.72    2.5.72-mm1    report
specsdet              P            N              Y             2.5.72    2.5.72-mm1    report
tbench                P            Y              N             2.5.72    2.5.72-mm1    report
tiobench.ext2         P            Y              Y             2.5.72    2.5.72-mm1    report
tiobench.ext3         P            Y              Y             2.5.72    2.5.72-mm1    report
tiobench.jfs          P            Y              N             2.5.72    2.5.72-mm1    report
tiobench.reiser       P            Y              Y             2.5.72    2.5.72-mm1    report
tiobench.xfs          P            Y              Y             2.5.72    2.5.72-mm1    report
volanomark            P            N              N             2.5.72    2.5.72-mm1    report

http://ltcperf.ncsa.uiuc.edu/data/2.5.72-mm1/2.5.72-vs-2.5.72-mm1/

Nightly Regression Summary
for
2.5.71 vs 2.5.72


Benchmark         Pass/Fail   Improvements   Regressions       Results       Results   Summary
---------------   ---------   ------------   -----------   -----------   -----------   -------

dbench.ext2           P            N              N             2.5.71        2.5.72    report
dbench.ext3           P            N              Y             2.5.71        2.5.72    report
dbench.jfs            P            N              N             2.5.71        2.5.72    report
dbench.reiser         P            N              N             2.5.71        2.5.72    report
dbench.xfs            P            N              N             2.5.71        2.5.72    report
kernbench             P            N              N             2.5.71        2.5.72    report
lmbench               P            Y              Y             2.5.71        2.5.72    report
rawiobench            P            Y              N             2.5.71        2.5.72    report
specjbb               P            Y              Y             2.5.71        2.5.72    report
specsdet              P            N              N             2.5.71        2.5.72    report
tbench                P            Y              Y             2.5.71        2.5.72    report
tiobench.ext2         P            N              N             2.5.71        2.5.72    report
tiobench.ext3         P            Y              N             2.5.71        2.5.72    report
tiobench.jfs          P            N              N             2.5.71        2.5.72    report
tiobench.reiser       P            Y              Y             2.5.71        2.5.72    report
tiobench.xfs          P            N              N             2.5.71        2.5.72    report
volanomark            P            N              N             2.5.71        2.5.72    report

http://ltcperf.ncsa.uiuc.edu/data/2.5.71/2.5.70-vs-2.5.71/

Nightly Regression Summary
for
2.5.70 vs 2.5.72


Benchmark         Pass/Fail   Improvements   Regressions       Results       Results   Summary
---------------   ---------   ------------   -----------   -----------   -----------   -------

dbench.ext2           P            Y              N             2.5.70        2.5.72    report
dbench.ext3           P            N              Y             2.5.70        2.5.72    report
dbench.jfs            P            N              N             2.5.70        2.5.72    report
dbench.reiser         P            N              N             2.5.70        2.5.72    report
dbench.xfs            P            N              N             2.5.70        2.5.72    report
kernbench             P            N              N             2.5.70        2.5.72    report
lmbench               P            Y              Y             2.5.70        2.5.72    report
rawiobench            P            Y              N             2.5.70        2.5.72    report
specjbb               P            Y              N             2.5.70        2.5.72    report
specsdet              P            N              N             2.5.70        2.5.72    report
tbench                P            Y              Y             2.5.70        2.5.72    report
tiobench.ext2         P            N              N             2.5.70        2.5.72    report
tiobench.ext3         P            Y              Y             2.5.70        2.5.72    report
tiobench.jfs          P            N              Y             2.5.70        2.5.72    report
tiobench.reiser       P            Y              Y             2.5.70        2.5.72    report
tiobench.xfs          P            Y              N             2.5.70        2.5.72    report
volanomark            P            N              N             2.5.70        2.5.72    report

http://ltcperf.ncsa.uiuc.edu/data/2.5.72/2.5.70-vs-2.5.72/

Nightly Regression Summary
for
2.5.71 vs 2.5.71-bk1


Benchmark         Pass/Fail   Improvements   Regressions       Results       Results   Summary
---------------   ---------   ------------   -----------   -----------   -----------   -------

dbench.ext2           P            N              N             2.5.71    2.5.71-bk1    report
dbench.ext3           P            N              Y             2.5.71    2.5.71-bk1    report
dbench.jfs            P            N              N             2.5.71    2.5.71-bk1    report
dbench.reiser         P            N              N             2.5.71    2.5.71-bk1    report
dbench.xfs            P            Y              N             2.5.71    2.5.71-bk1    report
kernbench             P            N              N             2.5.71    2.5.71-bk1    report
lmbench               P            Y              Y             2.5.71    2.5.71-bk1    report
rawiobench            P            N              N             2.5.71    2.5.71-bk1    report
specjbb               P            Y              Y             2.5.71    2.5.71-bk1    report
specsdet              P            N              N             2.5.71    2.5.71-bk1    report
tbench                P            Y              Y             2.5.71    2.5.71-bk1    report
tiobench.ext2         P            N              N             2.5.71    2.5.71-bk1    report
tiobench.ext3         P            Y              N             2.5.71    2.5.71-bk1    report
tiobench.jfs          P            N              N             2.5.71    2.5.71-bk1    report
tiobench.reiser       P            Y              Y             2.5.71    2.5.71-bk1    report
tiobench.xfs          P            Y              N             2.5.71    2.5.71-bk1    report
volanomark            P            N              N             2.5.71    2.5.71-bk1    report

http://ltcperf.ncsa.uiuc.edu/data/2.5.71-bk1/2.5.71-vs-2.5.71-bk1/

Nightly Regression Summary
for
2.5.71 vs 2.5.71-mjb1


Benchmark         Pass/Fail   Improvements   Regressions       Results       Results   Summary
---------------   ---------   ------------   -----------   -----------   -----------   -------

dbench.ext2           P            N              Y             2.5.71   2.5.71-mjb1    report
dbench.ext3           P            N              Y             2.5.71   2.5.71-mjb1    report
dbench.jfs            P            N              N             2.5.71   2.5.71-mjb1    report
dbench.reiser         P            Y              N             2.5.71   2.5.71-mjb1    report
dbench.xfs            P            N              N             2.5.71   2.5.71-mjb1    report
kernbench             P            N              N             2.5.71   2.5.71-mjb1    report
lmbench               P            Y              Y             2.5.71   2.5.71-mjb1    report
rawiobench            P            Y              Y             2.5.71   2.5.71-mjb1    report
specjbb               P            Y              Y             2.5.71   2.5.71-mjb1    report
specsdet              P            N              N             2.5.71   2.5.71-mjb1    report
tbench                P            Y              N             2.5.71   2.5.71-mjb1    report
tiobench.ext2         P            Y              Y             2.5.71   2.5.71-mjb1    report
tiobench.ext3         P            Y              Y             2.5.71   2.5.71-mjb1    report
tiobench.jfs          P            N              Y             2.5.71   2.5.71-mjb1    report
tiobench.reiser       P            Y              Y             2.5.71   2.5.71-mjb1    report
tiobench.xfs          P            Y              Y             2.5.71   2.5.71-mjb1    report
volanomark            P            N              N             2.5.71   2.5.71-mjb1    report

http://ltcperf.ncsa.uiuc.edu/data/2.5.71-mjb1/2.5.71-vs-2.5.71-mjb1/

Mark



