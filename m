Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261468AbVCRGcL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261468AbVCRGcL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 01:32:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261470AbVCRGcL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 01:32:11 -0500
Received: from jade.aracnet.com ([216.99.193.136]:20889 "EHLO
	jade.spiritone.com") by vger.kernel.org with ESMTP id S261468AbVCRGcK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 01:32:10 -0500
Date: Thu, 17 Mar 2005 22:32:13 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: ppc64 build broke between 2.6.11-bk6 and 2.6.11-bk7
Message-ID: <445800000.1111127533@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/built-in.o(.text+0x182bc): In function `.matroxfb_probe':
: undefined reference to `.mac_vmode_to_var'
make: *** [.tmp_vmlinux1] Error 1

Anyone know what that is?

M.

