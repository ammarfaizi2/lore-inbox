Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264251AbTDPVXK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 17:23:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264424AbTDPVXK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 17:23:10 -0400
Received: from franka.aracnet.com ([216.99.193.44]:5073 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S264251AbTDPVXJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 17:23:09 -0400
Date: Wed, 16 Apr 2003 14:35:01 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: LKML <linux-kernel@vger.kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 593] New: fb.h has syntax errors
Message-ID: <1490000.1050528901@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


http://bugme.osdl.org/show_bug.cgi?id=593

           Summary: fb.h has syntax errors
    Kernel Version: 2.5.67
            Status: NEW
          Severity: normal
             Owner: bugme-janitors@lists.osdl.org
         Submitter: btowe@gbis.com


Distribution: Gentoo
Hardware Environment:
Software Environment:
Problem Description: while trying to compile libsdl while using 2.5.67's
kernel headers i encountered this problem i did trace it down info and
patch can be found here: http://bugs.gentoo.org/show_bug.cgi?id=19307

Steps to reproduce:

