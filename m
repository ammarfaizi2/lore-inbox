Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262256AbVCOFKY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262256AbVCOFKY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 00:10:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262261AbVCOFKY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 00:10:24 -0500
Received: from fire.osdl.org ([65.172.181.4]:50363 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262256AbVCOFJG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 00:09:06 -0500
Date: Mon, 14 Mar 2005 21:09:49 -0800
From: John Cherry <cherry@osdl.org>
Message-Id: <200503150509.j2F59nWC024660@ibm-f.pdx.osdl.net>
To: linux-kernel@vger.kernel.org
Subject: IA32 (2.6.11 - 2005-03-14.16.00) - 2 New warnings
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/char/drm/i915_dma.c:573: warning: `verify_area' is deprecated (declared at include/asm/uaccess.h:105)
drivers/char/drm/i915_dma.c:603: warning: `verify_area' is deprecated (declared at include/asm/uaccess.h:105)
