Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269798AbUJAOd6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269798AbUJAOd6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 10:33:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269799AbUJAOd6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 10:33:58 -0400
Received: from fw.osdl.org ([65.172.181.6]:33473 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269798AbUJAOd6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 10:33:58 -0400
Date: Fri, 1 Oct 2004 07:33:56 -0700
From: John Cherry <cherry@osdl.org>
Message-Id: <200410011433.i91EXuPq018027@cherrypit.pdx.osdl.net>
To: linux-kernel@vger.kernel.org
Subject: IA32 (2.6.9-rc3 - 2004-09-30.21.30) - 1 New warnings (gcc 3.2.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/char/cyclades.c:5594: warning: assignment makes integer from pointer without a cast
