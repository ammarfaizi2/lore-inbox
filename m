Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264668AbUJRIl4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264668AbUJRIl4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 04:41:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264704AbUJRIlz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 04:41:55 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:25477 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S264668AbUJRIlw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 04:41:52 -0400
Date: Mon, 18 Oct 2004 14:13:12 +0530
From: Prasanna S Panchamukhi <prasanna@in.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org, Andrew Morton <akpm@osdl.org>, ak@muc.de,
       suparna@in.ibm.com, prasanna@in.ibm.com
Subject: [0/2] PATCH Kernel watchpoint interface-2.6.9-rc4-mm1 
Message-ID: <20041018084312.GG27204@in.ibm.com>
Reply-To: prasanna@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Often kernel developer try to moniter global variables.
These patches provide a simple interface for monitering global variables.
Please see the comments in the watchpoint patch for details.
These patches can be applied over 2.6.9-rc4-mm1.

Please provide your comments.

Thanks
Prasanna
-- 

Prasanna S Panchamukhi
Linux Technology Center
India Software Labs, IBM Bangalore
Ph: 91-80-25044636
<prasanna@in.ibm.com>
