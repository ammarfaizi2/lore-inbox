Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263646AbTFAOyh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 10:54:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264637AbTFAOyh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 10:54:37 -0400
Received: from franka.aracnet.com ([216.99.193.44]:4225 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S263646AbTFAOyh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 10:54:37 -0400
Date: Sun, 01 Jun 2003 08:07:53 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 760] New: raid1 boot oops
Message-ID: <56540000.1054480073@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

           Summary: raid1 boot oops
    Kernel Version: 2.5.70-bk5
            Status: NEW
          Severity: blocking
             Owner: bugme-janitors@lists.osdl.org
         Submitter: Nicolas.Mailhot@LaPoste.net


Distribution: Red Raw Hide

Hardware Environment:

GA-7VAX mobo 
http://www.giga-byte.com/products/7vax.htm 
(Via KT400 + Via VT8235 + Realtek RTL8100BL), F10 bios

Silicon Image 680 ATA controler
http://216.168.201.72/Site/E04/ProductContext.asp?SN=11810&Supplier_SN=1312&Site_Product_Classify_SN=10&Keyword=&test=

Software Environment: software Raid 1

Problem Description: oops on boot

