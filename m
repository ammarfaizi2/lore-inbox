Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264091AbRFKMAS>; Mon, 11 Jun 2001 08:00:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264244AbRFKMAH>; Mon, 11 Jun 2001 08:00:07 -0400
Received: from [32.97.182.102] ([32.97.182.102]:46520 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S264091AbRFKL7u>;
	Mon, 11 Jun 2001 07:59:50 -0400
From: kiran.thirumalai@in.ibm.com
X-Lotus-FromDomain: IBMIN@IBMAU
To: linux-kernel@vger.kernel.org
Message-ID: <CA256A68.00412D66.00@d73mta01.au.ibm.com>
Date: Mon, 11 Jun 2001 17:11:52 +0530
Subject: Validating dynamically allocated kernel memory
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

PS: My previous post went through minus subject due to oversight
:-(...Apologising and resending ....


