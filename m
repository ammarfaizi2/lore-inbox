Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275841AbRI1Fob>; Fri, 28 Sep 2001 01:44:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275842AbRI1FoV>; Fri, 28 Sep 2001 01:44:21 -0400
Received: from [202.54.64.2] ([202.54.64.2]:30217 "EHLO ganesh.ctd.hctech.com")
	by vger.kernel.org with ESMTP id <S275841AbRI1FoN>;
	Fri, 28 Sep 2001 01:44:13 -0400
Message-ID: <EF836A380096D511AD9000B0D021B527147368@narmada.ctd.hcltech.com>
From: "Eshwar D - CTD, Chennai." <deshwar@ctd.hcltech.com>
To: linux-kernel@vger.kernel.org
Subject: Problem in accessing disks
Date: Fri, 28 Sep 2001 10:42:15 +0530
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hai,
		In one of my project I am using Linux-2.4.2. I have JBOD
(Just Bunch of Disks) connected to two machines using FC card (Fiber
channel)  . When I loaded driver the disks are identified randomly in two
machines. That is consider 1st computer is identified in a sequence of
disk1, disk2 ....etc ..... associated with the device file /dev/sda,
/dev/sdb .... etc as I see  it from 2 computer the associated sequence may
be difference. Is there any solution to match the sequence . If any body now
about problem help me.

Thanks
Eshwar



***********************************************************************
Disclaimer: 
This document is intended for transmission to the named recipient only.  If
you are not that person, you should note that legal rights reside in this
document and you are not authorized to access, read, disclose, copy, use or
otherwise deal with it and any such actions are prohibited and may be
unlawful. The views expressed in this document are not necessarily those of
HCL Technologies Ltd. Notice is hereby given that no representation,
contract or other binding obligation shall be created by this e-mail, which
must be interpreted accordingly. Any representations, contractual rights or
obligations shall be separately communicated in writing and signed in the
original by a duly authorized officer of the relevant company.
***********************************************************************


