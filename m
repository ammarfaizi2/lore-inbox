Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262558AbUCOMlo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 07:41:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262560AbUCOMlo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 07:41:44 -0500
Received: from fw.osdl.org ([65.172.181.6]:39125 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262558AbUCOMln (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 07:41:43 -0500
Date: Mon, 15 Mar 2004 04:41:41 -0800
From: John Cherry <cherry@osdl.org>
Message-Id: <200403151241.i2FCffs0029417@cherrypit.pdx.osdl.net>
To: linux-kernel@vger.kernel.org
Subject: IA32 (2.6.4 - 2004-03-14.22.30) - 5 New warnings (gcc 3.2.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

include/sound/initval.h:141: warning: `get_id' defined but not used
ld: Warning: size of symbol `mchannels' changed from 128 to 64 in sound/pci/au88x0/snd-au8820.o
ld: Warning: size of symbol `mchannels' changed from 64 to 128 in sound/pci/au88x0/snd-au8830.o
ld: Warning: size of symbol `rampchs' changed from 128 to 64 in sound/pci/au88x0/snd-au8820.o
ld: Warning: size of symbol `rampchs' changed from 64 to 128 in sound/pci/au88x0/snd-au8830.o
