Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265373AbUAPL60 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 06:58:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265378AbUAPL60
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 06:58:26 -0500
Received: from host213-160-108-25.dsl.vispa.com ([213.160.108.25]:28811 "HELO
	cenedra.office") by vger.kernel.org with SMTP id S265373AbUAPL6Z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 06:58:25 -0500
From: Andrew Walrond <andrew@walrond.org>
To: linux-kernel@vger.kernel.org
Subject: ACPI broken on all 9 of my machines :(
Date: Fri, 16 Jan 2004 11:58:13 +0000
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401161158.13780.andrew@walrond.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While investigating an ACPI problem (see another thread) it occured to me that 
of the 7 different machines I have in my immediate workspace, none of them 
work properly with ACPI in latest 2.4 or 2.6 kernels. I have P3, dual P3, P4, 
dual HT Xeons, Opteron and VIA Samuel based motherboards, Thinkpads A21p and 
A31p, and none of them work properly with ACPI. 100% failure.

Am I just unlucky? Or is this the general experience?

I have indeed bugzilled some of the problems, but will do a complete fresh set 
of tests on all the different types of machines, and present the results 
here.

Andrew Walrond

