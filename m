Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266687AbUINXDR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266687AbUINXDR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 19:03:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266680AbUINW7k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 18:59:40 -0400
Received: from fw.osdl.org ([65.172.181.6]:46314 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269594AbUINW44 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 18:56:56 -0400
Date: Tue, 14 Sep 2004 15:56:54 -0700 (PDT)
From: Judith Lebzelter <judith@osdl.org>
To: <linux-kernel@vger.kernel.org>
cc: <hannal@us.ibm.com>
Subject: [RFT 2.6.9-rc1 alpha sys_sio.c] [2/2] convert pci_find_device to
 pci_get_device
Message-ID: <Pine.LNX.4.33.0409141539200.22202-100000@osdlab.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I submitted these patches to PLM on linux-2.6.8. It automatically runs
compiles for several architectures, including 'alpha'.
   http://www.osdl.org/plm-cgi/plm?module=patch_info&patch_id=3315

The alpha filter does a 'defconfig' build, and it had 2 warnings, 0
errors.

Unfortunately, the 2.6.9-rc1 has a few errors for the 'defconfig' build,
which is why I did not apply it there.

Judith Lebzelter
OSDL


