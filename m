Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263057AbTDROIR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 10:08:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263062AbTDROIP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 10:08:15 -0400
Received: from franka.aracnet.com ([216.99.193.44]:30691 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S263057AbTDROIN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 10:08:13 -0400
Date: Fri, 18 Apr 2003 07:20:08 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 599] New: rtl8139 NIC don't work while CONFIG_ACPI=y
Message-ID: <22490000.1050675608@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=599

           Summary: rtl8139 NIC don't work while CONFIG_ACPI=y
    Kernel Version: 2.5.67
            Status: NEW
          Severity: normal
             Owner: andrew.grover@intel.com
         Submitter: farshad_kh@yahoo.com


Distribution: redhat 8.0

Hardware Environment: x86 (duran 1200)

Software Environment:

Problem Description:

RTL8139 don't add others to arp table but answer to others arp requests
while CONFIG_ACPI=y

Steps to reproduce:

compile, boot and it won't work


