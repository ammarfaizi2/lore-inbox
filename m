Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262816AbTESUZZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 16:25:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262818AbTESUZZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 16:25:25 -0400
Received: from franka.aracnet.com ([216.99.193.44]:21704 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S262816AbTESUZY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 16:25:24 -0400
Date: Mon, 19 May 2003 13:38:18 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: LKML <linux-kernel@vger.kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 730] New: ide-floppy hangs the machine
Message-ID: <43550000.1053376698@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


           Summary: ide-floppy hangs the machine
    Kernel Version: 2.5.69-ac1
            Status: NEW
          Severity: high
             Owner: bugme-janitors@lists.osdl.org
         Submitter: greg@ulima.unil.ch


Distribution: Mandrake 9.2 (Cooker)
Hardware Environment: MSI Max2-BLR, with ICH4 IDE
Software Environment: ???
Problem Description: if compiled as module, modprobe just completely hangs the
machine, if compiled in, the boot goes till ide-floppy and stop here

Steps to reproduce: modprobe ide-floppy or compil in at boot


