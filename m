Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267855AbTBRPsO>; Tue, 18 Feb 2003 10:48:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267847AbTBRPsN>; Tue, 18 Feb 2003 10:48:13 -0500
Received: from franka.aracnet.com ([216.99.193.44]:52621 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S267858AbTBRPsJ>; Tue, 18 Feb 2003 10:48:09 -0500
Date: Tue, 18 Feb 2003 07:58:03 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: LKML <linux-kernel@vger.kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 373] New: Make rpm doesn't work
Message-ID: <5390000.1045583883@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


http://bugme.osdl.org/show_bug.cgi?id=373

           Summary: Make rpm doesn't work
    Kernel Version: 2.5.61
            Status: NEW
          Severity: normal
             Owner: bugme-janitors@lists.osdl.org
         Submitter: ciarrocchi@linuxmail.org


Distribution:Mandrake 9.0
Hardware Environment:
Software Environment:
Problem Description:Make rpm doesn't work

Steps to reproduce:
[root@frodo linux-2.5.61]# make rpm
make: *** No rule to make target `clean', needed by `rpm'.  Stop

