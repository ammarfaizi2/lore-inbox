Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267441AbRGLGVX>; Thu, 12 Jul 2001 02:21:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267442AbRGLGVN>; Thu, 12 Jul 2001 02:21:13 -0400
Received: from ausmtp02.au.ibm.COM ([202.135.136.105]:18828 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP
	id <S267441AbRGLGVC>; Thu, 12 Jul 2001 02:21:02 -0400
From: mdaljeet@in.ibm.com
X-Lotus-FromDomain: IBMIN@IBMAU
To: linux-kernel@vger.kernel.org
Message-ID: <CA256A87.0022B31D.00@d73mta01.au.ibm.com>
Date: Thu, 12 Jul 2001 11:47:46 +0530
Subject: physical adddress ranges
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there anyway I can find out the physical address ranges being used by a
user process?
/proc/<pid>/maps gives the process's VMA information.
is there another interface to find the physical address ranges being used
by process at a particular time?

regards,
Daljeet.


