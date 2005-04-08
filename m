Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262753AbVDHIyB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262753AbVDHIyB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 04:54:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262756AbVDHIyB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 04:54:01 -0400
Received: from zone4.gcu-squad.org ([213.91.10.50]:6369 "EHLO
	zone4.gcu-squad.org") by vger.kernel.org with ESMTP id S262753AbVDHIx6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 04:53:58 -0400
Date: Fri, 8 Apr 2005 10:49:16 +0200 (CEST)
To: ladis@linux-mips.org
Subject: Re: [PATCH] ds1337 1/4
X-IlohaMail-Blah: khali@localhost
X-IlohaMail-Method: mail() [mem]
X-IlohaMail-Dummy: moo
X-Mailer: IlohaMail/0.8.14 (On: webmail.gcu.info)
Message-ID: <CN3QLeGu.1112950156.8219610.khali@localhost>
In-Reply-To: <20050407231758.GB27226@orphique>
From: "Jean Delvare" <khali@linux-fr.org>
Bounce-To: "Jean Delvare" <khali@linux-fr.org>
CC: "LKML" <linux-kernel@vger.kernel.org>,
       "LM Sensors" <sensors@Stimpy.netroedge.com>,
       "James Chapman" <jchapman@katalix.com>, "Greg KH" <greg@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Ladislav,

> Use i2c_transfer to send message, so we get proper bus locking.

Looks all OK to me, let alone the lack of Signed-off-by line, as Greg
underlined elsewhere. Please resent the patches with the Signed-off-by
line after I finish reviewing them.

Thanks,
--
Jean Delvare
