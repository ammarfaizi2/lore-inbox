Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269146AbTB0BH6>; Wed, 26 Feb 2003 20:07:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269147AbTB0BH6>; Wed, 26 Feb 2003 20:07:58 -0500
Received: from franka.aracnet.com ([216.99.193.44]:10146 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S269146AbTB0BH5>; Wed, 26 Feb 2003 20:07:57 -0500
Date: Wed, 26 Feb 2003 17:18:13 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: LKML <linux-kernel@vger.kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 414] New: pnp patches broke drivers/pcmcia/i82365.c
Message-ID: <12330000.1046308693@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=414

           Summary: pnp patches broke drivers/pcmcia/i82365.c
    Kernel Version: 2.5.63
            Status: NEW
          Severity: high
             Owner: bugme-janitors@lists.osdl.org
         Submitter: donaldlf@i-55.com


Distribution:rawhide
Hardware Environment:LX164/Alpha
Software Environment:redhat
Problem Description:
Kernel fails to compile. An pnp update changed an argument list
breaking existing code.


Steps to reproduce:

select the i62365 module for pcmicia
Attempt to compile.


