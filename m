Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262813AbTFKQjg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 12:39:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262955AbTFKQjg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 12:39:36 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:65493 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262813AbTFKQj0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 12:39:26 -0400
Message-ID: <3EE75E39.9090400@austin.ibm.com>
Date: Wed, 11 Jun 2003 11:52:09 -0500
From: Mark Peloquin <peloquin@austin.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>, linstab <linstab@osdl.org>,
       ltp-results <ltp-results@lists.sourceforge.net>
Subject: [BENCHMARK] bk15, mm7 regression results
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nightly Regression Summary
for
2.5.70 vs 2.5.70-bk15


Benchmark         Pass/Fail   Improvements   Regressions       
Results       Results   Summary
---------------   ---------   ------------   -----------   -----------   
-----------   -------

dbench.ext2           P            N              N             2.5.70   
2.5.70-bk15    report
dbench.ext3           P            N              N             2.5.70   
2.5.70-bk15    report
dbench.jfs            P            N              N             2.5.70   
2.5.70-bk15    report
dbench.reiser         P            N              N             2.5.70   
2.5.70-bk15    report
dbench.xfs            P            N              N             2.5.70   
2.5.70-bk15    report
kernbench             P            N              N             2.5.70   
2.5.70-bk15    report
lmbench               P            Y              Y             2.5.70   
2.5.70-bk15    report
rawiobench            P            Y              N             2.5.70   
2.5.70-bk15    report
specjbb               P            Y              Y             2.5.70   
2.5.70-bk15    report
specsdet              P            N              Y             2.5.70   
2.5.70-bk15    report
tbench                P            Y              Y             2.5.70   
2.5.70-bk15    report
tiobench.ext2         P            N              N             2.5.70   
2.5.70-bk15    report
tiobench.ext3         P            N              Y             2.5.70   
2.5.70-bk15    report
tiobench.jfs          P            N              Y             2.5.70   
2.5.70-bk15    report
tiobench.reiser       P            Y              Y             2.5.70   
2.5.70-bk15    report
tiobench.xfs          P            N              N             2.5.70   
2.5.70-bk15    report
volanomark            P            N              N             2.5.70   
2.5.70-bk15    report

http://ltcperf.ncsa.uiuc.edu/data/2.5.70-bk15/2.5.70-vs-2.5.70-bk15/

Nightly Regression Summary
for
2.5.70-bk14 vs 2.5.70-bk15


Benchmark         Pass/Fail   Improvements   Regressions       
Results       Results   Summary
---------------   ---------   ------------   -----------   -----------   
-----------   -------

dbench.ext2           P            N              N        2.5.70-bk14   
2.5.70-bk15    report
dbench.ext3           P            N              Y        2.5.70-bk14   
2.5.70-bk15    report
dbench.jfs            P            N              N        2.5.70-bk14   
2.5.70-bk15    report
dbench.reiser         P            N              N        2.5.70-bk14   
2.5.70-bk15    report
dbench.xfs            P            N              N        2.5.70-bk14   
2.5.70-bk15    report
kernbench             P            N              N        2.5.70-bk14   
2.5.70-bk15    report
lmbench               P            Y              Y        2.5.70-bk14   
2.5.70-bk15    report
rawiobench            P            Y              Y        2.5.70-bk14   
2.5.70-bk15    report
specjbb               P            N              Y        2.5.70-bk14   
2.5.70-bk15    report
specsdet              P            N              Y        2.5.70-bk14   
2.5.70-bk15    report
tbench                P            Y              Y        2.5.70-bk14   
2.5.70-bk15    report
tiobench.ext2         P            N              N        2.5.70-bk14   
2.5.70-bk15    report
tiobench.ext3         P            Y              Y        2.5.70-bk14   
2.5.70-bk15    report
tiobench.jfs          P            N              Y        2.5.70-bk14   
2.5.70-bk15    report
tiobench.reiser       P            Y              Y        2.5.70-bk14   
2.5.70-bk15    report
tiobench.xfs          P            N              Y        2.5.70-bk14   
2.5.70-bk15    report
volanomark            P            N              N        2.5.70-bk14   
2.5.70-bk15    report

http://ltcperf.ncsa.uiuc.edu/data/2.5.70-bk15/2.5.70-bk14-vs-2.5.70-bk15/

Nightly Regression Summary
for
2.5.70 vs 2.5.70-mm7


Benchmark         Pass/Fail   Improvements   Regressions       
Results       Results   Summary
---------------   ---------   ------------   -----------   -----------   
-----------   -------

dbench.ext2           P            N              N             
2.5.70    2.5.70-mm7    report
dbench.ext3           P            Y              Y             
2.5.70    2.5.70-mm7    report
dbench.jfs            P            N              N             
2.5.70    2.5.70-mm7    report
dbench.reiser         P            N              N             
2.5.70    2.5.70-mm7    report
dbench.xfs            P            N              N             
2.5.70    2.5.70-mm7    report
kernbench             P            N              N             
2.5.70    2.5.70-mm7    report
lmbench               P            Y              Y             
2.5.70    2.5.70-mm7    report
rawiobench            P            Y              Y             
2.5.70    2.5.70-mm7    report
specjbb               P            Y              N             
2.5.70    2.5.70-mm7    report
specsdet              P            N              Y             
2.5.70    2.5.70-mm7    report
tbench                P            Y              N             
2.5.70    2.5.70-mm7    report
tiobench.ext2         P            Y              N             
2.5.70    2.5.70-mm7    report
tiobench.ext3         P            Y              Y             
2.5.70    2.5.70-mm7    report
tiobench.jfs          P            Y              Y             
2.5.70    2.5.70-mm7    report
tiobench.reiser       P            Y              Y             
2.5.70    2.5.70-mm7    report
tiobench.xfs          P            Y              Y             
2.5.70    2.5.70-mm7    report
volanomark            P            N              N             
2.5.70    2.5.70-mm7    report

http://ltcperf.ncsa.uiuc.edu/data/2.5.70-mm7/2.5.70-vs-2.5.70-mm7/

Nightly Regression Summary
for
2.5.70-mm6 vs 2.5.70-mm7


Benchmark         Pass/Fail   Improvements   Regressions       
Results       Results   Summary
---------------   ---------   ------------   -----------   -----------   
-----------   -------

dbench.ext2           P            N              N         
2.5.70-mm6    2.5.70-mm7    report
dbench.ext3           P            N              N         
2.5.70-mm6    2.5.70-mm7    report
dbench.jfs            P            N              N         
2.5.70-mm6    2.5.70-mm7    report
dbench.reiser         P            N              N         
2.5.70-mm6    2.5.70-mm7    report
dbench.xfs            P            N              N         
2.5.70-mm6    2.5.70-mm7    report
kernbench             P            N              N         
2.5.70-mm6    2.5.70-mm7    report
lmbench               P            Y              Y         
2.5.70-mm6    2.5.70-mm7    report
rawiobench            P            Y              Y         
2.5.70-mm6    2.5.70-mm7    report
specjbb               P            Y              Y         
2.5.70-mm6    2.5.70-mm7    report
specsdet              P            N              N         
2.5.70-mm6    2.5.70-mm7    report
tbench                P            Y              Y         
2.5.70-mm6    2.5.70-mm7    report
tiobench.ext2         P            Y              Y         
2.5.70-mm6    2.5.70-mm7    report
tiobench.ext3         P            Y              Y         
2.5.70-mm6    2.5.70-mm7    report
tiobench.jfs          P            Y              Y         
2.5.70-mm6    2.5.70-mm7    report
tiobench.reiser       P            Y              Y         
2.5.70-mm6    2.5.70-mm7    report
tiobench.xfs          P            Y              Y         
2.5.70-mm6    2.5.70-mm7    report
volanomark            P            N              N         
2.5.70-mm6    2.5.70-mm7    report

http://ltcperf.ncsa.uiuc.edu/data/2.5.70-mm7/2.5.70-mm6-vs-2.5.70-mm7/

Mark

