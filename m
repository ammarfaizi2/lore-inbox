Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261468AbVCWOIL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261468AbVCWOIL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 09:08:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262398AbVCWOIK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 09:08:10 -0500
Received: from web53308.mail.yahoo.com ([206.190.39.237]:40287 "HELO
	web53308.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261468AbVCWOID (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 09:08:03 -0500
Message-ID: <20050323140803.15895.qmail@web53308.mail.yahoo.com>
Date: Wed, 23 Mar 2005 14:08:02 +0000 (GMT)
From: sounak chakraborty <sounakrin@yahoo.co.in>
Subject: error while implementing kill()
To: linux kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  
dear sir,
 I am unable to use the system call kill(pid,sig).I
have included the header file <signal.h>. I used it in
a module to kill a process. The module is compiling
properly but giving the following error while
inserting the module,
   unresolved symbol kill()

I am unable to track the bug here. 
kindly help me out.

I want to kill a process through the process ID inside
a module.
Is there any other approach other than using the
kill() function?

Thanks in advance,

sounak

________________________________________________________________________
Yahoo! India Matrimony: Find your partner online. http://yahoo.shaadi.com/india-matrimony/
