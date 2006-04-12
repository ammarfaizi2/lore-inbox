Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932252AbWDLVNs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932252AbWDLVNs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 17:13:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932262AbWDLVNs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 17:13:48 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:55499 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932252AbWDLVNr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 17:13:47 -0400
Message-ID: <443D6D81.2030009@vnet.ibm.com>
Date: Wed, 12 Apr 2006 16:13:37 -0500
From: Michael Reed <mreedltp@vnet.ibm.com>
Reply-To: mreedltp@vnet.ibm.com
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, ltp-announce@lists.sourceforge.net,
       ltp-list@lists.sourceforge.net
Subject: [ANNOUNCE]  The Linux Test project ltp-20060412 Re-Released
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

There are two problems with the current release of LTP, therefore I 
updating the release from yesterday and re-releasing it.

   - The patch to /lib/parse_opts.c was removed because it was causing 
testcases writev01 - 05 and ftest06 to fail.

   - Also, I removed an additional ltp directory located in the top LTP 
directory that was unnecessary.  


Michael Reed


