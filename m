Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262321AbUKKTwI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262321AbUKKTwI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 14:52:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262320AbUKKTwH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 14:52:07 -0500
Received: from natnoddy.rzone.de ([81.169.145.166]:11911 "EHLO
	natnoddy.rzone.de") by vger.kernel.org with ESMTP id S262334AbUKKTtU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 14:49:20 -0500
Subject: [alpha] linux-2.6.10-rc1-bk20 compile error
From: Alexander Rauth <Alexander.Rauth@promotion-ie.de>
Reply-To: Alexander.Rauth@promotion-ie.de
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: linux-alpha <linux-alpha@vger.kernel.org>
Content-Type: text/plain
Organization: Pro/Motion Industrie-Elektronik GmbH
Date: Thu, 11 Nov 2004 20:49:30 +0100
Message-Id: <1100202570.26565.3.camel@pro30.local.promotion-ie.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


error appears with linux-2.6.10-rc1-bk20:

  CC      arch/alpha/kernel/setup.o
arch/alpha/kernel/setup.c: In function `setup_arch':
arch/alpha/kernel/setup.c:597: warning: implicit declaration of function
`__sysrq_get_key_op'
arch/alpha/kernel/setup.c:597: warning: initialization makes pointer
from integer without a cast
make[1]: *** [arch/alpha/kernel/setup.o] Error 1
make: *** [arch/alpha/kernel] Error 2

-- 
Alexander Rauth <Alexander.Rauth@promotion-ie.de>
Pro/Motion Industrie-Elektronik GmbH

