Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264190AbTFYNGQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 09:06:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264266AbTFYNGP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 09:06:15 -0400
Received: from fmr01.intel.com ([192.55.52.18]:44781 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id S264190AbTFYNGO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 09:06:14 -0400
Message-ID: <A5974D8E5F98D511BB910002A50A66470B54CC21@hdsmsx103.hd.intel.com>
From: "Cress, Andrew R" <andrew.r.cress@intel.com>
To: "'tomas'" <ertra@volny.cz>, linux-kernel@vger.kernel.org
Subject: RE: Intel RAID hw card
Date: Wed, 25 Jun 2003 06:25:37 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, use the gdth driver (sorry the linkage isn't clearer).

Andy

-----Original Message-----
From: tomas [mailto:ertra@volny.cz] 
Sent: Tuesday, June 24, 2003 6:17 PM
To: linux-kernel@vger.kernel.org
Subject: Intel RAID hw card


Hi all,

I have looked on google and tryed to find an answer, if
linux kernel supports

Intel Server RAID Controller U3-1LA (SRCU31LA)

but I did not find a clear answer,

please, could somebody tell me if I can use linux (Redhat 9 for example)
with this hw RAID card for raid 1 without problems ?


Thanks a lot
Tomas Zeman

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
