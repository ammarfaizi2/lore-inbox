Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266518AbUFQOwj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266518AbUFQOwj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 10:52:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266524AbUFQOwj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 10:52:39 -0400
Received: from tartu.cyber.ee ([193.40.6.68]:57093 "EHLO tartu.cyber.ee")
	by vger.kernel.org with ESMTP id S266518AbUFQOwi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 10:52:38 -0400
From: Meelis Roos <mroos@linux.ee>
To: linux-kernel@vger.kernel.org
Subject: Re: Proposal for new generic device API: dma_get_required_mask()
In-Reply-To: <1087481331.2210.27.camel@mulgrave>
User-Agent: tin/1.7.5-20040615 ("Gighay") (UNIX) (Linux/2.6.7-rc3 (i686))
Message-Id: <E1BayF0-0004b1-83@rhn.tartu-labor>
Date: Thu, 17 Jun 2004 17:51:46 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

JB> Once the driver has the platform's optimal mask, it can use this to
JB> decide on the correct descriptor size.
JB> 
JB> Comments?

Would it break with memory hotplug?

-- 
Meelis Roos
