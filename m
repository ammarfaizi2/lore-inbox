Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265699AbTFSCG4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 22:06:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265701AbTFSCG4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 22:06:56 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:64177 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S265699AbTFSCGz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 22:06:55 -0400
Message-ID: <3EF11D5C.3030808@austin.ibm.com>
Date: Wed, 18 Jun 2003 21:18:04 -0500
From: Mark Peloquin <peloquin@austin.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>, linstab <linstab@osdl.org>,
       ltp-results <ltp-results@lists.sourceforge.net>
Subject: [BENCHMARK] 2.4.20 vs 2.5.71 comparison
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Thought some of you might get a kick out of seeing this. :)

Nightly Regression Summary
for
2.4.20 vs 2.5.71


Benchmark         Pass/Fail   Improvements   Regressions       Results       Results   Summary
---------------   ---------   ------------   -----------   -----------   -----------   -------

dbench.ext2           P            Y              N             2.4.20        2.5.71    report
dbench.ext3           P            Y              N             2.4.20        2.5.71    report
dbench.jfs            P            Y              N             2.4.20        2.5.71    report
dbench.reiser         P            Y              N             2.4.20        2.5.71    report
dbench.xfs            P            Y              N             2.4.20        2.5.71    report
kernbench             P            N              N             2.4.20        2.5.71    report
lmbench               P            Y              Y             2.4.20        2.5.71    report
rawiobench            P            Y              N             2.4.20        2.5.71    report
specjbb               P            Y              Y             2.4.20        2.5.71    report
specsdet              P            Y              N             2.4.20        2.5.71    report
tbench                P            Y              N             2.4.20        2.5.71    report
tiobench.ext2         P            Y              Y             2.4.20        2.5.71    report
tiobench.ext3         P            Y              Y             2.4.20        2.5.71    report
tiobench.jfs          P            Y              Y             2.4.20        2.5.71    report
tiobench.reiser       P            Y              Y             2.4.20        2.5.71    report
tiobench.xfs          P            Y              Y             2.4.20        2.5.71    report
volanomark            P            Y              N             2.4.20        2.5.71    report

http://ltcperf.ncsa.uiuc.edu/data/2.5.71/2.4.20-vs-2.5.71/

Mark



