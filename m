Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263170AbVCKFLD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263170AbVCKFLD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 00:11:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263177AbVCKFLD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 00:11:03 -0500
Received: from fire.osdl.org ([65.172.181.4]:8939 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263170AbVCKFLA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 00:11:00 -0500
Date: Thu, 10 Mar 2005 21:11:42 -0800
From: John Cherry <cherry@osdl.org>
Message-Id: <200503110511.j2B5BgaW004816@ibm-f.pdx.osdl.net>
To: linux-kernel@vger.kernel.org
Subject: IA32 (2.6.11 - 2005-03-10.16.00) - 1 New warnings
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/video/intelfb/intelfbdrv.h:31: warning: 'intelfb_setup' declared `static' but never defined
