Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268557AbTGSTld (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jul 2003 15:41:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270481AbTGSTld
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jul 2003 15:41:33 -0400
Received: from ws-han1.win-ip.dfn.de ([193.174.75.150]:9335 "EHLO
	ws-han1.win-ip.dfn.de") by vger.kernel.org with ESMTP
	id S268557AbTGSTlc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jul 2003 15:41:32 -0400
Date: Sat, 19 Jul 2003 21:59:18 +0200
Message-ID: <vines.sxdD+KAO4zA@SZKOM.BFS.DE>
X-Priority: 3 (Normal)
To: <linux-kernel@vger.kernel.org>
From: <WHarms@bfs.de> (Walter Harms)
Reply-To: <WHarms@bfs.de>
Subject: bug alpha configure linux-2.6.0-test1
X-Incognito-SN: 25185
X-Incognito-Version: 5.1.0.84
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi ppl
i tried the new linux-2.6.0-test1 with my alpha and the
config says:

./scripts/kconfig/mconf arch/alpha/Kconfig
boolean symbol BINFMT_ZFLAT tested for 'm'? test forced to 'n'
#
# using defaults found in arch/alpha/defconfig
#
arch/alpha/defconfig:244: trying to assign nonexistent symbol SCSI_NCR53C8XX


hope that helps
walter
