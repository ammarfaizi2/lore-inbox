Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262824AbTESU0J (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 16:26:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262827AbTESU0J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 16:26:09 -0400
Received: from franka.aracnet.com ([216.99.193.44]:39369 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S262824AbTESU0F
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 16:26:05 -0400
Date: Mon, 19 May 2003 13:39:00 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 731] New: Errors message and paused system with IDE ZIP 
Message-ID: <43700000.1053376740@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

           Summary: Errors message and paused system with IDE ZIP
    Kernel Version: 2.5.69
            Status: NEW
          Severity: normal
             Owner: alan@lxorguk.ukuu.org.uk
         Submitter: greg@ulima.unil.ch


Distribution: Mandrake 9.2 (Cooker)
Hardware Environment: MSI Max2-BLR with ICH4 IDE
Software Environment: ???
Problem Description: I got those errors:
May 11 15:12:39 localhost kernel: hdb: DMA interrupt recovery
May 11 15:12:39 localhost kernel: hdb: lost interrupt

I was thinking the problem came because it was slave, so I put the disc as
master withtout slave:

May 18 01:35:42 localhost kernel: hda: DMA interrupt recovery
May 18 01:35:42 localhost kernel: hda: lost interrupt

These message aren't so annoying, but when they accurs, the system is near a
"pause" mode and react really bad...

Steps to reproduce: wait...


