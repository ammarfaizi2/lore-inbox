Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268249AbUHXCr5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268249AbUHXCr5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 22:47:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268206AbUHXCr4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 22:47:56 -0400
Received: from alt.aurema.com ([203.217.18.57]:30895 "EHLO smtp.sw.oz.au")
	by vger.kernel.org with ESMTP id S266491AbUHXCrx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 22:47:53 -0400
Message-ID: <412AAC1D.5050104@bigpond.net.au>
Date: Tue, 24 Aug 2004 12:46:53 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Michal Kaczmarski <fallow@op.pl>, Shane Shrybman <shrybman@aei.ca>
Subject: [PATCH] V-5.0.1 Single Priority Array O(1) CPU Scheduler Evaluation
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Version 5.0.1 of various single priority array scheduler patches for the 
2.6.8.1 kernel are now available for download and evaluation.  This is a 
bug fix release to fix a problem whereby using non zero soft caps in 
"pb" mode could cause a system hang.  Only spa_pb, zaphod and hydra 
schedulers are effected.  Full patches and patches from 5.0 to 5.0.1 are 
available as follows:

SPA_PB:
<http://prdownloads.sourceforge.net/cpuse/patch-2.6.8.1-spa_pb_FULL-v5.0.1?download>
<http://prdownloads.sourceforge.net/cpuse/patch-2.6.8.1-spa_pb-v5.0-to-v5.0.1?download>

ZAPHOD:
<http://prdownloads.sourceforge.net/cpuse/patch-2.6.8.1-spa_zaphod_FULL-v5.0.1?download>
<http://prdownloads.sourceforge.net/cpuse/patch-2.6.8.1-spa_zaphod-v5.0-to-v5.0.1?download>

HYDRA:
<http://prdownloads.sourceforge.net/cpuse/patch-2.6.8.1-spa_hydra_FULL-v5.0.1?download>
<http://prdownloads.sourceforge.net/cpuse/patch-2.6.8.1-spa_hydra-v5.0-to-v5.0.1?download>

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce

