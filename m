Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263100AbUHYIzA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263100AbUHYIzA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 04:55:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263429AbUHYIzA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 04:55:00 -0400
Received: from gizmo10ps.bigpond.com ([144.140.71.20]:45978 "HELO
	gizmo10ps.bigpond.com") by vger.kernel.org with SMTP
	id S263100AbUHYIyu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 04:54:50 -0400
Message-ID: <412C53D6.3040202@bigpond.net.au>
Date: Wed, 25 Aug 2004 18:54:46 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Michal Kaczmarski <fallow@op.pl>, Shane Shrybman <shrybman@aei.ca>
Subject: Re: [PATCH] V-5.0.1 Single Priority Array O(1) CPU Scheduler Evaluation
References: <412AAC1D.5050104@bigpond.net.au>
In-Reply-To: <412AAC1D.5050104@bigpond.net.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Williams wrote:
> Version 5.0.1 of various single priority array scheduler patches for the 
> 2.6.8.1 kernel are now available for download and evaluation.  This is a 
> bug fix release to fix a problem whereby using non zero soft caps in 
> "pb" mode could cause a system hang.  Only spa_pb, zaphod and hydra 
> schedulers are effected.  Full patches and patches from 5.0 to 5.0.1 are 
> available as follows:
> 
> SPA_PB:
> <http://prdownloads.sourceforge.net/cpuse/patch-2.6.8.1-spa_pb_FULL-v5.0.1?download> 
> 
> <http://prdownloads.sourceforge.net/cpuse/patch-2.6.8.1-spa_pb-v5.0-to-v5.0.1?download> 
> 
> 
> ZAPHOD:
> <http://prdownloads.sourceforge.net/cpuse/patch-2.6.8.1-spa_zaphod_FULL-v5.0.1?download> 
> 
> <http://prdownloads.sourceforge.net/cpuse/patch-2.6.8.1-spa_zaphod-v5.0-to-v5.0.1?download> 
> 
> 
> HYDRA:
> <http://prdownloads.sourceforge.net/cpuse/patch-2.6.8.1-spa_hydra_FULL-v5.0.1?download> 
> 
> <http://prdownloads.sourceforge.net/cpuse/patch-2.6.8.1-spa_hydra-v5.0-to-v5.0.1?download> 

Now available for 2.6.9-rc1:

ZAPHOD: 
<http://prdownloads.sourceforge.net/cpuse/patch-2.6.9-rc1-spa_zaphod_FULL-v5.0.1?download>

HYDRA: 
<http://prdownloads.sourceforge.net/cpuse/patch-2.6.9-rc1-spa_hydra_FULL-v5.0.1?download>

Others at <https://sourceforge.net/projects/cpuse/>

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce

