Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263730AbTDDOtg (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 09:49:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263733AbTDDOsz (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 09:48:55 -0500
Received: from franka.aracnet.com ([216.99.193.44]:37807 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S263730AbTDDOmT (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Apr 2003 09:42:19 -0500
Date: Fri, 04 Apr 2003 06:53:40 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: LKML <linux-kernel@vger.kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 540] New: Difficulty configuring component as module in gconfig
Message-ID: <2340000.1049468020@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


http://bugme.osdl.org/show_bug.cgi?id=540

           Summary: Difficulty configuring component as module in gconfig
    Kernel Version: 2.5.66-bk9
            Status: NEW
          Severity: normal
             Owner: zippel@linux-m68k.org
         Submitter: k.oriordan@oceanfree.net


Distribution: Mandrake Linux 9.1

Hardware Environment: Laptop - mobile athlon4 processor, 512 MB RAM, via motherboard

Software Environment: GNOME 2.2, gcc 3.2.2

Problem Description: When configuring kernel options through gconfig,the check
boxes show either selected or unselected. Can't get option to configure as module.
Also where there is a choice of 1 of many, checkboxes are displayed instead of
radio buttons.

Steps to reproduce: Run make gconfig

