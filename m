Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261947AbUE3Owa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261947AbUE3Owa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 May 2004 10:52:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262029AbUE3Ow3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 May 2004 10:52:29 -0400
Received: from fw.osdl.org ([65.172.181.6]:27058 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261947AbUE3Ow3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 May 2004 10:52:29 -0400
Date: Sun, 30 May 2004 07:52:25 -0700
From: John Cherry <cherry@osdl.org>
Message-Id: <200405301452.i4UEqP2t024107@cherrypit.pdx.osdl.net>
To: linux-kernel@vger.kernel.org
Subject: IA32 (2.6.7-rc1 - 2004-05-29.22.30) - 1 New warnings (gcc 3.2.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fs/nfs/direct.c:549: warning: initialization discards qualifiers from pointer target type
