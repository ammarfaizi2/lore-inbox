Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265251AbTFRO2O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 10:28:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265252AbTFRO2O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 10:28:14 -0400
Received: from franka.aracnet.com ([216.99.193.44]:41932 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S265251AbTFRO2M
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 10:28:12 -0400
Date: Wed, 18 Jun 2003 07:42:04 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 827] New: System time runs too fast.
Message-ID: <10940000.1055947324@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

           Summary: System time runs too fast.
    Kernel Version: 2.5.72
            Status: NEW
          Severity: normal
             Owner: bugme-janitors@lists.osdl.org
         Submitter: ialiashkevich@epo.org


Distribution:

Hardware Environment:
Notebook Maxdata Eco 3000X
Processor: P4 2Gz
Chipset: SIS650

Software Environment:
RedHat 8.0 + kernel 2.5.70
RedHat 9.0 + kernel 2.5.72
kernels were built by gcc 3.2.3 using default .config from arch/i386

Problem Description:
System time runs at least twice faster than necessary.
As a result have problems with keyboard timings:
   very short delay before repeat mode and very fast repeat rate
problems with mouse:
   very fast double-click speed
   
Steps to reproduce:
  buld, install kernel and restart :)


-----------------------------------------


PS. We've noticed this too on an x440 ;-)

Martin.

