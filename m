Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265776AbUG0NhN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265776AbUG0NhN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 09:37:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265462AbUG0NhM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 09:37:12 -0400
Received: from fw.osdl.org ([65.172.181.6]:48824 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265776AbUG0NeB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 09:34:01 -0400
Date: Tue, 27 Jul 2004 06:33:55 -0700
From: John Cherry <cherry@osdl.org>
Message-Id: <200407271333.i6RDXtGI008250@cherrypit.pdx.osdl.net>
To: linux-kernel@vger.kernel.org
Subject: IA32 (2.6.8-rc2 - 2004-07-26.22.30) - 1 New warnings (gcc 3.2.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

net/ipv6/route.c:696: warning: `ipv6_advmss' declared inline after being called
