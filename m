Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262484AbTJJGpv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 02:45:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262540AbTJJGpv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 02:45:51 -0400
Received: from fw.osdl.org ([65.172.181.6]:64670 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262484AbTJJGpv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 02:45:51 -0400
Date: Thu, 9 Oct 2003 23:45:50 -0700
From: John Cherry <cherry@osdl.org>
Message-Id: <200310100645.h9A6joFZ008847@cherrypit.pdx.osdl.net>
To: linux-kernel@vger.kernel.org
Subject: IA32 (2.6.0-test7 - 2003-10-09.18.30) - 1 New warnings (gcc 3.2.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/media/common/saa7146_vbi.c:6: warning: `vbi_workaround' defined but not used
