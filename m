Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268114AbUHFPW7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268114AbUHFPW7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 11:22:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266009AbUHFPW7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 11:22:59 -0400
Received: from fw.osdl.org ([65.172.181.6]:11913 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268114AbUHFPWw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 11:22:52 -0400
Date: Fri, 6 Aug 2004 08:22:48 -0700
From: John Cherry <cherry@osdl.org>
Message-Id: <200408061522.i76FMmtu011488@cherrypit.pdx.osdl.net>
To: linux-kernel@vger.kernel.org
Subject: IA32 (2.6.8-rc3 - 2004-08-05.22.30) - 1 New warnings (gcc 3.2.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/oprofile/oprofilefs.c:50: warning: passing arg 4 of `simple_read_from_buffer' discards qualifiers from pointer target type
