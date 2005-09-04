Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932151AbVIDXbR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932151AbVIDXbR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 19:31:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932126AbVIDXbQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 19:31:16 -0400
Received: from allen.werkleitz.de ([80.190.251.108]:23937 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S932102AbVIDX34
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 19:29:56 -0400
Message-Id: <20050904232259.777473000@abc>
Date: Mon, 05 Sep 2005 01:22:59 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
X-SA-Exim-Connect-IP: 84.189.198.88
Subject: [DVB patch 00/54] DVB update
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

here's another DVB update, mostly small fixes and improvements.
Patches have been prepared against 2.6.13-git4 and IMHO could
go straight into Linus' tree, but have been tested to apply
cleanly against 2.6.13-mm1.

The dvb-bt8xx-dst-doc-update.patch depends on
dvb-clarify-description-text-for-dvb-bt8xx-in-kconfig-fix.patch
which is currently in -mm1.

Please apply.

Thanks,
Johannes

