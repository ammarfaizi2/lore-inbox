Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265782AbUFTLdC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265782AbUFTLdC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 07:33:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265793AbUFTLdC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 07:33:02 -0400
Received: from fw.osdl.org ([65.172.181.6]:56705 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265782AbUFTLdB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 07:33:01 -0400
Date: Sun, 20 Jun 2004 04:33:00 -0700
From: John Cherry <cherry@osdl.org>
Message-Id: <200406201133.i5KBX0sh017539@cherrypit.pdx.osdl.net>
To: linux-kernel@vger.kernel.org
Subject: IA32 (2.6.7 - 2004-06-19.22.30) - 6 New warnings (gcc 3.2.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/net/skfp/skfddi.c:912: warning: passing arg 2 of `mac_add_multicast' from incompatible pointer type
drivers/net/skfp/smt.c:386: warning: passing arg 2 of `smt_send_nif' discards qualifiers from pointer target type
drivers/net/skfp/smt.c:399: warning: passing arg 2 of `is_equal' discards qualifiers from pointer target type
drivers/net/skfp/smt.c:421: warning: passing arg 2 of `is_equal' discards qualifiers from pointer target type
drivers/net/skfp/smt.c:588: warning: passing arg 2 of `is_equal' discards qualifiers from pointer target type
drivers/net/skfp/smt.c:645: warning: passing arg 2 of `is_equal' discards qualifiers from pointer target type
