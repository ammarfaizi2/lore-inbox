Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263409AbRFKFWt>; Mon, 11 Jun 2001 01:22:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263407AbRFKFWj>; Mon, 11 Jun 2001 01:22:39 -0400
Received: from [32.97.182.103] ([32.97.182.103]:37821 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S263405AbRFKFW2>;
	Mon, 11 Jun 2001 01:22:28 -0400
From: kiran.thirumalai@in.ibm.com
X-Lotus-FromDomain: IBMIN@IBMAU
To: linux-kernel@vger.kernel.org
Message-ID: <CA256A68.001C53EA.00@d73mta01.au.ibm.com>
Date: Mon, 11 Jun 2001 10:28:43 +0530
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Is there some kernel api to validate memory allocated using kmalloc.
Suppose, I allocate some memory using kmalloc and at a later point of
execution
I would like to validate if the memory allocated is not possibly freed by
some other thread.

Pls suggest a patch/pointers if any.
I also noticed a commented 'CONFIG_DEBUG_MALLOC' config option  (2.4.3
source),
It doesn't seem to be functional.  Any pointers towards the history behind
it would also be helpful.

Thanks in advance,
Kiran




