Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262681AbUCKJYR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 04:24:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262772AbUCKJYR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 04:24:17 -0500
Received: from math.ut.ee ([193.40.5.125]:60560 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S262681AbUCKJYK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 04:24:10 -0500
Date: Thu, 11 Mar 2004 11:24:02 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
To: linux-kernel@vger.kernel.org
Subject: megaraid warnings on sparc64 (2.6.4)
Message-ID: <Pine.GSO.4.44.0403111123190.29042-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FYI:

  CC [M]  drivers/scsi/megaraid.o
drivers/scsi/megaraid.c: In function `megadev_ioctl':
drivers/scsi/megaraid.c:3500: warning: cast to pointer from integer of different size
drivers/scsi/megaraid.c:3552: warning: cast to pointer from integer of different size
drivers/scsi/megaraid.c:3578: warning: cast to pointer from integer of different size
drivers/scsi/megaraid.c:3630: warning: cast to pointer from integer of different size
drivers/scsi/megaraid.c:3670: warning: cast to pointer from integer of different size
drivers/scsi/megaraid.c: In function `mega_n_to_m':
drivers/scsi/megaraid.c:3857: warning: cast to pointer from integer of different size
drivers/scsi/megaraid.c:3873: warning: cast to pointer from integer of different size

-- 
Meelis Roos (mroos@linux.ee)

