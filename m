Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262449AbTCFSmd>; Thu, 6 Mar 2003 13:42:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268168AbTCFSmd>; Thu, 6 Mar 2003 13:42:33 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:32456 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S262449AbTCFSmc>; Thu, 6 Mar 2003 13:42:32 -0500
Date: Thu, 06 Mar 2003 10:43:41 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 443] New: warnings from sound/pci/cs46xx/cs46xx_lib.c
Message-ID: <1380000.1046976221@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=443

           Summary: warnings from sound/pci/cs46xx/cs46xx_lib.c:
    Kernel Version: 2.5.63
            Status: NEW
          Severity: normal
             Owner: bugme-janitors@lists.osdl.org
         Submitter: mbligh@aracnet.com


sound/pci/cs46xx/cs46xx_lib.c: In function `snd_cs46xx_playback_hw_params':
sound/pci/cs46xx/cs46xx_lib.c:1027: warning: unused variable `period_size'
sound/pci/cs46xx/cs46xx_lib.c:1026: warning: unused variable `sample_rate'
sound/pci/cs46xx/cs46xx_lib.c:1025: warning: unused variable `chip'
sound/pci/cs46xx/cs46xx_lib.c: In function `snd_cs46xx_capture_hw_params':
sound/pci/cs46xx/cs46xx_lib.c:1214: warning: unused variable `period_size'
sound/pci/cs46xx/cs46xx_lib.c: At top level:
sound/pci/cs46xx/cs46xx_lib.c:1406: warning: `hw_constraints_period_sizes'
defined but not used


