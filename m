Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263012AbTIVGPp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 02:15:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263014AbTIVGPp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 02:15:45 -0400
Received: from fw.osdl.org ([65.172.181.6]:48572 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263012AbTIVGPo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 02:15:44 -0400
Date: Sun, 21 Sep 2003 23:15:41 -0700
From: John Cherry <cherry@osdl.org>
Message-Id: <200309220615.h8M6Ff5Q031500@cherrypit.pdx.osdl.net>
To: linux-kernel@vger.kernel.org
Subject: IA32 - 3 New warnings (gcc 3.2.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/net/wan/wanxl.c:34: warning: `version' defined but not used
fs/smbfs/proc.c:216: warning: initialization from incompatible pointer type
fs/smbfs/proc.c:217: warning: initialization from incompatible pointer type
