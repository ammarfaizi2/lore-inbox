Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130284AbRBVKAB>; Thu, 22 Feb 2001 05:00:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130296AbRBVJ7w>; Thu, 22 Feb 2001 04:59:52 -0500
Received: from alpham.uni-mb.si ([164.8.1.101]:48655 "EHLO alpham.uni-mb.si")
	by vger.kernel.org with ESMTP id <S130284AbRBVJ70>;
	Thu, 22 Feb 2001 04:59:26 -0500
Date: Thu, 22 Feb 2001 10:58:21 +0100
From: Igor Mozetic <igor.mozetic@uni-mb.si>
Subject: 3c59x in 2.4.{0,1,2}
To: linux-kernel@vger.kernel.org
Cc: andrewm@uow.edu.au
Message-id: <14996.58045.843929.411743@ravan.camtp.uni-mb.si>
MIME-version: 1.0
X-Mailer: VM 6.90 under Emacs 20.7.2
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is probably just some miscoordination between the kernel
mainteiners, but anyway. The 3c59x driver shipped with all 
official 2.4.x kernels lacks the 'medialock' feature.
The result on 3c900 10M/combo cards can be unpleasant:
kernel log fills up quickly and only reboot helps.
However, Andrew's unofficial drivers at
http://www.uow.edu.au/~andrewm/linux/ work fine so this is 
just a plea to include them into the official kernel.

-Igor Mozetic
