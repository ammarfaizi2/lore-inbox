Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262235AbUBXLiK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 06:38:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262236AbUBXLiK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 06:38:10 -0500
Received: from fw.osdl.org ([65.172.181.6]:20434 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262235AbUBXLhs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 06:37:48 -0500
Date: Tue, 24 Feb 2004 03:37:46 -0800
From: John Cherry <cherry@osdl.org>
Message-Id: <200402241137.i1OBbkcx010216@cherrypit.pdx.osdl.net>
To: linux-kernel@vger.kernel.org
Subject: IA32 (2.6.3 - 2004-02-23.22.30) - 1 New warnings (gcc 3.2.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/isdn/i4l/isdn_v110.c:523: warning: `ret' might be used uninitialized in this function
