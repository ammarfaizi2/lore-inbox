Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261799AbTJGGgo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 02:36:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261802AbTJGGgn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 02:36:43 -0400
Received: from fw.osdl.org ([65.172.181.6]:44935 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261799AbTJGGgn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 02:36:43 -0400
Date: Mon, 6 Oct 2003 23:36:42 -0700
From: John Cherry <cherry@osdl.org>
Message-Id: <200310070636.h976agNd019288@cherrypit.pdx.osdl.net>
To: linux-kernel@vger.kernel.org
Subject: IA32 (2.6.0-test6 - 2003-10-06.18.30) - 2 New warnings (gcc 3.2.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fs/smbfs/ioctl.c:34: warning: unreachable code at beginning of switch statement
mm/memory.c:1276: warning: statement with no effect
