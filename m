Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261249AbTFJSLx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 14:11:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261280AbTFJSLx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 14:11:53 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:32727 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261249AbTFJSLo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 14:11:44 -0400
Date: Tue, 10 Jun 2003 11:14:08 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: linux-kernel <linux-kernel@vger.kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 797] New: error during shutdown "eth1: error -110 writing Tx descriptor to BAP" (fwd)
Message-ID: <25600000.1055268848@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=797

           Summary: error during shutdown "eth1: error -110 writing Tx
                    descriptor to BAP"
    Kernel Version: 2.5.70
            Status: NEW
          Severity: normal
             Owner: jgarzik@pobox.com
         Submitter: cmeisch@designtechnica.com


Distribution: Mandrake Cooker
Hardware Environment: HP Omnibook XE4500
Software Environment:
Problem Description: System became very slow, decided to reboot. During
shutdown, recieved message:  "eth1: error -110 writing Tx descriptor to BAP"
Steps to reproduce:
This does not happen consistantly. Not sure how to reproduce.

Output from ver_linux:
Linux q004117.vcd.hp.com 2.5.70 #6 Sat Jun 7 22:19:18 PDT 2003 i686 unknown unkn
own GNU/Linux
  
Gnu C                  3.3
Gnu make               3.80
util-linux             2.11z
mount                  2.11z
e2fsprogs              1.32
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.1.9
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.0
Modules Loaded         orinoco_pci orinoco hermes natsemi


