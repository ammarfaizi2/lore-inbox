Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263360AbUCNNkU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Mar 2004 08:40:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263362AbUCNNkU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Mar 2004 08:40:20 -0500
Received: from fw.osdl.org ([65.172.181.6]:40156 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263360AbUCNNkS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Mar 2004 08:40:18 -0500
Date: Sun, 14 Mar 2004 05:40:16 -0800
From: John Cherry <cherry@osdl.org>
Message-Id: <200403141340.i2EDeGCh026063@cherrypit.pdx.osdl.net>
To: linux-kernel@vger.kernel.org
Subject: IA32 (2.6.4 - 2004-03-13.22.30) - 3 New warnings (gcc 3.2.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/media/dvb/frontends/tda1004x.c:191: warning: `errno' defined but not used
sound/isa/wavefront/wavefront_synth.c:1923: warning: `errno' defined but not used
sound/oss/wavfront.c:2498: warning: `errno' defined but not used
