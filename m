Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261357AbVEQXH1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261357AbVEQXH1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 19:07:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261448AbVEQXH1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 19:07:27 -0400
Received: from dvhart.com ([64.146.134.43]:20386 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S261357AbVEQXHR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 19:07:17 -0400
Date: Tue, 17 May 2005 16:07:14 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: problems with mpt fusion driver since 2.6.12-rc3
Message-ID: <912220000.1116371234@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get this on boot since -rc3 ... -rc2 worked fine.
Is on a 4-way Newisys amd64 box.

Is this a known bug, or something new?

^M^@Fusion MPT base driver 3.01.20
^M^@Copyright (c) 1999-2004 LSI Logic Corporation
^M^@ACPI: PCI Interrupt 0000:02:04.0[A] -> GSI 27 (level, low) -> IRQ 27
^M^@mptbase: Initiating ioc0 bringup
^M^@mptbase: ioc0: ERROR - Wait IOC_READY state timeout(15)!
^M^@mptbase: ioc0: ERROR - Enable Diagnostic mode FAILED! (00h)
^M^@mptbase: ioc0 NOT READY WARNING!
^M^@mptbase: WARNING - ioc0 did not initialize properly! (-1)
^M^@mptbase: probe of 0000:02:04.0 failed with error -1
^M^@Fusion MPT SCSI Host driver 3.01.20

