Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261849AbTCZSGJ>; Wed, 26 Mar 2003 13:06:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261850AbTCZSGJ>; Wed, 26 Mar 2003 13:06:09 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:57781 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S261849AbTCZSGI>; Wed, 26 Mar 2003 13:06:08 -0500
Date: Wed, 26 Mar 2003 10:07:25 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 507] New: CS4232, CS4236 drivers do not compile 
Message-ID: <1437260000.1048702045@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=507

           Summary: CS4232, CS4236 drivers do not compile
    Kernel Version: 2.5.66
            Status: NEW
          Severity: normal
             Owner: bugme-janitors@lists.osdl.org
         Submitter: pavelr@coresma.com


Distribution: RedHat 8.0
Hardware Environment: pentium 2 
Software Environment:
Problem Description: CS4232 and CS4236 sound drivers fail to compile due to
missing members in isapnp_dev structure.

Steps to reproduce:
Select CS4232 or CS4236+ drivers to compile.

