Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261668AbUFQSj4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261668AbUFQSj4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 14:39:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261685AbUFQSi7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 14:38:59 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:2312 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261668AbUFQSgE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 14:36:04 -0400
Date: Thu, 17 Jun 2004 10:53:59 -0700
Message-Id: <200406171753.i5HHrx38015816@fire-2.osdl.org>
From: bugme-daemon@osdl.org
To: rmk@arm.linux.org.uk
Subject: [Bug 2905] New: Aironet 340 PCMCIA card not working since 2.6.7
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Category: Drivers
X-Bugzilla-Component: PCMCIA
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=2905

           Summary: Aironet 340 PCMCIA card not working since 2.6.7
    Kernel Version: 2.6.7
            Status: NEW
          Severity: normal
             Owner: rmk@arm.linux.org.uk
         Submitter: hadmut@danisch.de


Distribution: Debian
Hardware Environment: Dell Inspiron 3800, Cisco
  Aironet 340 PCMCIA card
Software Environment:
  Debian
Problem Description:

The system was working well with 
2.4.x and 2.6.x kernels up to 2.6.6.

After upgrade to 2.6.7 the WLAN does n
not work anymore: There is no error message, 
no warning, everything looks fine, except
for the fact that traffic is not possible.

Maybe a WEP problem?

regards
Hadmut

------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
