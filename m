Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262961AbUJ1Lbh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262961AbUJ1Lbh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 07:31:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262969AbUJ1Lbh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 07:31:37 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:57577 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262961AbUJ1Lau
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 07:30:50 -0400
Date: Thu, 28 Oct 2004 17:02:08 +0530
From: Prasanna S Panchamukhi <prasanna@in.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org, Andrew Morton <akpm@osdl.org>, ak@muc.de,
       suparna@in.ibm.com, dprobes@www-124.southbury.usf.ibm.com,
       prasanna@in.ibm.com
Subject: [0/3] PATCH Kprobes for x86_64- 2.6.9-final
Message-ID: <20041028113208.GA11182@in.ibm.com>
Reply-To: prasanna@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Below are the Kprobes patches ported to x86_64 architecture.
I have updated these patches with suggestions from Andi Kleen.
Thanks Andi for reviewing and providing your feedback.
These patches can be applied over 2.6.9-final. Please
see the description in the individual patches.

Please review and provide your feedback.

[1/3] kprobes-arch-i386-changes.patch 
[2/3] kprobes-x86_64-port-2.6.9-final.patch
[3/3] kprobes-arch-sparc64-changes.patch 

Thanks
Prasanna
-- 

Prasanna S Panchamukhi
Linux Technology Center
India Software Labs, IBM Bangalore
Ph: 91-80-25044636
<prasanna@in.ibm.com>
