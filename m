Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269213AbUJFOJT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269213AbUJFOJT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 10:09:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269245AbUJFOJT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 10:09:19 -0400
Received: from fw.osdl.org ([65.172.181.6]:50881 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269213AbUJFOJO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 10:09:14 -0400
Date: Wed, 6 Oct 2004 07:09:12 -0700
From: John Cherry <cherry@osdl.org>
Message-Id: <200410061409.i96E9CAZ012878@cherrypit.pdx.osdl.net>
To: linux-kernel@vger.kernel.org
Subject: IA32 (2.6.9-rc3 - 2004-10-05.21.30) - 1 New warnings (gcc 3.2.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/net/tokenring/olympic.c:1404: warning: unused variable `i'
