Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266838AbUGLNdo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266838AbUGLNdo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 09:33:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266831AbUGLNdn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 09:33:43 -0400
Received: from fw.osdl.org ([65.172.181.6]:24511 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266837AbUGLNdj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 09:33:39 -0400
Date: Mon, 12 Jul 2004 06:33:37 -0700
From: John Cherry <cherry@osdl.org>
Message-Id: <200407121333.i6CDXbvV022701@cherrypit.pdx.osdl.net>
To: linux-kernel@vger.kernel.org
Subject: IA32 (2.6.8-rc1 - 2004-07-11.22.30) - 1 New warnings (gcc 3.2.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fs/afs/mntpt.c:185: warning: assignment from incompatible pointer type
