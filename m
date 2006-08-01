Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751748AbWHASJH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751748AbWHASJH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 14:09:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751752AbWHASJH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 14:09:07 -0400
Received: from math.ut.ee ([193.40.36.2]:23533 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S1751747AbWHASJF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 14:09:05 -0400
Date: Tue, 1 Aug 2006 21:09:03 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: ppc prep boot failure in 2.6.18-rc3
Message-ID: <Pine.SOC.4.61.0608012106350.3786@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tried yesterdays 2.6.18-rc3+git snapshot on a ppc prep machine 
(Motorola Powerstack II). While 2.6.17 worked fine (modulo patched 
x_tables alignment), this kernel does not even boot:

Uncompressing Linux... inflate returned FFFFFFFE
exit

-- 
Meelis Roos (mroos@linux.ee)
