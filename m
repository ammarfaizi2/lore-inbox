Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261267AbUBYLgE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 06:36:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261268AbUBYLgE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 06:36:04 -0500
Received: from fw.osdl.org ([65.172.181.6]:51685 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261267AbUBYLgC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 06:36:02 -0500
Date: Wed, 25 Feb 2004 03:36:01 -0800
From: John Cherry <cherry@osdl.org>
Message-Id: <200402251136.i1PBa15G006518@cherrypit.pdx.osdl.net>
To: linux-kernel@vger.kernel.org
Subject: IA32 (2.6.3 - 2004-02-24.22.30) - 3 New warnings (gcc 3.2.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/scsi/aacraid/rkt.c:335: warning: `aac_rkt_check_health' defined but not used
drivers/scsi/aacraid/rx.c:335: warning: `aac_rx_check_health' defined but not used
drivers/scsi/aacraid/sa.c:310: warning: `aac_sa_check_health' defined but not used
