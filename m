Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262411AbSJVKqR>; Tue, 22 Oct 2002 06:46:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262420AbSJVKqR>; Tue, 22 Oct 2002 06:46:17 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:46297 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S262411AbSJVKqR>; Tue, 22 Oct 2002 06:46:17 -0400
Date: Tue, 22 Oct 2002 16:36:00 +0530
From: "Vamsi Krishna S ." <vamsi@in.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: rusty@rustcorp.com.au, richard <richardj_moore@uk.ibm.com>,
       suparna <suparna@in.ibm.com>, bharata <bharata@in.ibm.com>
Subject: [patch 0/4] kprobes patches for 2.5.44
Message-ID: <20021022163600.A26609@in.ibm.com>
Reply-To: vamsi@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is the latest set of kprobes patches for 2.5.44. It is essentially 
same as the last one I sent out for 2.5.40. On top of that, I am sending
additional patches to get kprobes closer to dprobes full version.

0/1 - this
1/1 - kprobes - base - same as the one Rusty has been sending, just
                upgraded to 2.5.44.
2/1 - kprobes - debug register management
3/1 - kprobes - kwatch points
4/1 - kprobes - user space probes

Any comments, especially about the addon patches welcome.
-- 
Vamsi Krishna S.
Linux Technology Center,
IBM Software Lab, Bangalore.
Ph: +91 80 5044959
Internet: vamsi@in.ibm.com
