Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265978AbUH0PPP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265978AbUH0PPP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 11:15:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266034AbUH0POf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 11:14:35 -0400
Received: from fire.osdl.org ([65.172.181.4]:48003 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S266137AbUH0PNa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 11:13:30 -0400
Subject: 2 New compile/sparse warnings (nightly build)
From: John Cherry <cherry@osdl.org>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1093619350.2467.17.camel@cherrybomb.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Fri, 27 Aug 2004 08:09:10 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Summary:
   New warnings = 2
   Fixed warnings = 8

New warnings:
-------------
drivers/usb/gadget/inode.c:587:19: warning: Using plain integer as NULL
pointer

drivers/usb/gadget/inode.c:706:47: warning: Using plain integer as NULL
pointer

Fixed warnings:
---------------
drivers/char/ipmi/ipmi_poweroff.c:427:56: warning: Using plain integer
as NULL pointer

drivers/scsi/fdomain.c:767: warning: `check_region' is deprecated
(declared at include/linux/ioport.h:121)

drivers/scsi/wd7000.c:746:14: warning: cast to non-scalar
drivers/scsi/wd7000.c:746:14: warning: cast to non-scalar
drivers/scsi/wd7000.c:746:14: warning: cast to non-scalar
drivers/scsi/wd7000.c:746:14: warning: cast to non-scalar
drivers/scsi/wd7000.c:746:14: warning: cast to non-scalar
drivers/scsi/wd7000.c:746:14: warning: cast to non-scalar
drivers/scsi/wd7000.c:746:14: warning: cast to non-scalar
drivers/scsi/wd7000.c:746:14: warning: cast to non-scalar
drivers/scsi/wd7000.c:746:14: warning: cast to non-scalar
drivers/scsi/wd7000.c:746:14: warning: cast to non-scalar

drivers/scsi/wd7000.c:747:14: warning: cast to non-scalar
drivers/scsi/wd7000.c:747:14: warning: cast to non-scalar
drivers/scsi/wd7000.c:747:14: warning: cast to non-scalar
drivers/scsi/wd7000.c:747:14: warning: cast to non-scalar
drivers/scsi/wd7000.c:747:14: warning: cast to non-scalar
drivers/scsi/wd7000.c:747:14: warning: cast to non-scalar
drivers/scsi/wd7000.c:747:14: warning: cast to non-scalar
drivers/scsi/wd7000.c:747:14: warning: cast to non-scalar
drivers/scsi/wd7000.c:747:14: warning: cast to non-scalar
drivers/scsi/wd7000.c:747:14: warning: cast to non-scalar

drivers/scsi/wd7000.c:748:14: warning: cast to non-scalar
drivers/scsi/wd7000.c:748:14: warning: cast to non-scalar
drivers/scsi/wd7000.c:748:14: warning: cast to non-scalar
drivers/scsi/wd7000.c:748:14: warning: cast to non-scalar
drivers/scsi/wd7000.c:748:14: warning: cast to non-scalar
drivers/scsi/wd7000.c:748:14: warning: cast to non-scalar
drivers/scsi/wd7000.c:748:14: warning: cast to non-scalar
drivers/scsi/wd7000.c:748:14: warning: cast to non-scalar
drivers/scsi/wd7000.c:748:14: warning: cast to non-scalar
drivers/scsi/wd7000.c:748:14: warning: cast to non-scalar

include/linux/usb.h:892:21: warning: shift too big for type (40)

net/ipv4/netfilter/ip_conntrack_proto_sctp.c:69:5: warning: Using plain
integer as NULL pointer

net/sunrpc/auth_gss/gss_spkm3_seal.c:129:16: warning: Using plain
integer as NULL pointer



