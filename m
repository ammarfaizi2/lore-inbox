Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263578AbUDMObk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 10:31:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263581AbUDMObk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 10:31:40 -0400
Received: from fw.osdl.org ([65.172.181.6]:20426 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263578AbUDMObj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 10:31:39 -0400
Date: Tue, 13 Apr 2004 07:31:38 -0700
From: John Cherry <cherry@osdl.org>
Message-Id: <200404131431.i3DEVcCg010071@cherrypit.pdx.osdl.net>
To: linux-kernel@vger.kernel.org
Subject: IA32 (2.6.5 - 2004-04-12.22.30) - 2 New warnings (gcc 3.2.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/char/cyclades.c:686: warning: `cy_get_user' defined but not used
drivers/video/fbmem.c:914: warning: passing arg 1 of `copy_from_user' discards qualifiers from pointer target type
