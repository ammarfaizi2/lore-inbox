Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265910AbUIVO3Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265910AbUIVO3Q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 10:29:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265900AbUIVO3Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 10:29:16 -0400
Received: from fw.osdl.org ([65.172.181.6]:52452 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265971AbUIVO1y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 10:27:54 -0400
Date: Wed, 22 Sep 2004 07:27:51 -0700
From: John Cherry <cherry@osdl.org>
Message-Id: <200409221427.i8MERpfE028704@cherrypit.pdx.osdl.net>
To: linux-kernel@vger.kernel.org
Subject: IA32 (2.6.9-rc2 - 2004-09-21.21.30) - 2 New warnings (gcc 3.2.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

net/ipv4/netfilter/ipchains_core.c:1:2: warning: #warning ipchains is obsolete, and will be removed soon.
net/ipv4/netfilter/ipfwadm_core.c:1:2: warning: #warning ipfwadm is obsolete, and will be removed soon.
