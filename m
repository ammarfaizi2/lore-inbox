Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261172AbTD1QHo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Apr 2003 12:07:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261184AbTD1QHo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Apr 2003 12:07:44 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:31636 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261172AbTD1QHn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Apr 2003 12:07:43 -0400
Subject: Question on which headers to use when compiling 2.5 kernels
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 6.0 September 26, 2002
Message-ID: <OF60B60028.F8DD3823-ON85256D16.0058E5AD-86256D16.0059CC01@pok.ibm.com>
From: "Robert Williamson" <robbiew@us.ibm.com>
Date: Mon, 28 Apr 2003 11:19:48 -0500
X-MIMETrack: Serialize by Router on D01ML076/01/M/IBM(Release 5.0.11 +SPRs MIAS5EXFG4, MIAS5AUFPV
 and DHAG4Y6R7W, MATTEST |November 8th, 2002) at 04/28/2003 12:19:52 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I would REALLY appreciate it, if someone could clarify this issue for me.
When testing the latest 2.5 kernels, I've frequently come across issues
where the headers in /usr/include conflict with the headers packaged with
the kernel.  I was under the assumption that when compiling user mode
programs, such as the LTP test suite, we should use the headers in
/usr/include.  However, I have had some kernel developers tell me that I
should compile against the kernel includes.....could I get some
clarification on this?

- Robbie

Robert V. Williamson <robbiew@us.ibm.com>
Linux Test Project
IBM Linux Technology Center
Phone: (512) 838-9295   T/L: 678-9295
Fax: (512) 838-4603
Web: http://ltp.sourceforge.net
IRC: #ltp on freenode.irc.net
====================
"Only two things are infinite, the universe and human stupidity, and I'm
not sure about the former." -Albert Einstein


