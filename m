Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265492AbUFSLf4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265492AbUFSLf4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 07:35:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265499AbUFSLf4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 07:35:56 -0400
Received: from fw.osdl.org ([65.172.181.6]:58761 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265492AbUFSLfz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 07:35:55 -0400
Date: Sat, 19 Jun 2004 04:35:54 -0700
From: John Cherry <cherry@osdl.org>
Message-Id: <200406191135.i5JBZsXL017823@cherrypit.pdx.osdl.net>
To: linux-kernel@vger.kernel.org
Subject: IA32 (2.6.7 - 2004-06-18.22.30) - 2 New warnings (gcc 3.2.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/net/cs89x0.c:166: warning: `netcard_portlist' defined but not used
drivers/video/tdfxfb.c:1104: warning: initialization discards qualifiers from pointer target type
