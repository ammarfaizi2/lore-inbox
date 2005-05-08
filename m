Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262939AbVEHT7U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262939AbVEHT7U (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 May 2005 15:59:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262940AbVEHT6d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 May 2005 15:58:33 -0400
Received: from ipx10786.ipxserver.de ([80.190.251.108]:4247 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262939AbVEHTKT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 May 2005 15:10:19 -0400
Message-Id: <20050508184229.957247000@abc>
Date: Sun, 08 May 2005 20:42:29 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
X-SA-Exim-Connect-IP: 217.231.45.168
Subject: [DVB patch 00/37] DVB updates for 2.6.12-rc4
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

here are a bunch of patches from linuxtv.org CVS. Nothing
exciting, just bugfixes, cleanups and support for a number
of new card variants.

One hunk from my previous patchset didn't make it into
2.6.12-rc4, but still lingers somewhere in rc3-mm3,
thus the "make dvb_class static" patch will be rejected
when applying to -rc3-mm3:
dvb-core/dvbdev.c from http://lkml.org/lkml/2005/3/21/321

Please apply.

Thanks,
Johannes

