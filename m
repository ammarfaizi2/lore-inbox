Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265102AbUGDQeJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265102AbUGDQeJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jul 2004 12:34:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265157AbUGDQeJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jul 2004 12:34:09 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:21635 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S265102AbUGDQeH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jul 2004 12:34:07 -0400
Subject: Strange DMA timeouts
From: Lasse Bang Mikkelsen <lbm-list@fatalerror.dk>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1088958931.3205.8.camel@slaptop>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 04 Jul 2004 18:35:31 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I keep getting these DMA timeouts under heavy harddrive load, ex. when
unpacking big tarballs, transfering from USB harddrive etc.

hda: dma_timer_expiry: dma status == 0x21
hda: DMA timeout error
hda: dma timeout error: status=0xd0 { Busy }

hda: DMA disabled
ide0: reset: success

Is this a sign of harddisk failure or could this be a kernel problem?

Thanks.

-- 
Regards

Lasse Bang Mikkelsen
lbm@fatalerror.dk

