Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262859AbUB0NP4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 08:15:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262863AbUB0NP4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 08:15:56 -0500
Received: from fw.osdl.org ([65.172.181.6]:17877 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262859AbUB0NPu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 08:15:50 -0500
Date: Fri, 27 Feb 2004 05:15:48 -0800
From: John Cherry <cherry@osdl.org>
Message-Id: <200402271315.i1RDFmEf026199@cherrypit.pdx.osdl.net>
To: linux-kernel@vger.kernel.org
Subject: IA32 (2.6.3 - 2004-02-26.22.30) - 1 New warnings (gcc 3.2.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/media/dvb/frontends/stv0299.c:356: warning: unused variable `i'
