Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261187AbVCIFDQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261187AbVCIFDQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 00:03:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261168AbVCIFDQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 00:03:16 -0500
Received: from fire.osdl.org ([65.172.181.4]:10685 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261181AbVCIFC5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 00:02:57 -0500
Date: Tue, 8 Mar 2005 21:03:34 -0800
From: John Cherry <cherry@osdl.org>
Message-Id: <200503090503.j2953Ynx027894@ibm-f.pdx.osdl.net>
To: linux-kernel@vger.kernel.org
Subject: IA32 (2.6.11 - 2005-03-08.16.00) - 1 New warnings
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/w1/w1.c:525: warning: assignment makes pointer from integer without a cast
