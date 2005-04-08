Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262756AbVDHIzx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262756AbVDHIzx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 04:55:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262767AbVDHIzx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 04:55:53 -0400
Received: from zone4.gcu-squad.org ([213.91.10.50]:64480 "EHLO
	zone4.gcu-squad.org") by vger.kernel.org with ESMTP id S262756AbVDHIzo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 04:55:44 -0400
Date: Fri, 8 Apr 2005 10:51:00 +0200 (CEST)
To: ladis@linux-mips.org
Subject: Re: [PATCH] ds1337 2/4
X-IlohaMail-Blah: khali@localhost
X-IlohaMail-Method: mail() [mem]
X-IlohaMail-Dummy: moo
X-Mailer: IlohaMail/0.8.14 (On: webmail.gcu.info)
Message-ID: <okTF4WNV.1112950260.5841330.khali@localhost>
In-Reply-To: <20050407231820.GC27226@orphique>
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

> Use correct macros to convert between bdc and bin. See linux/bcd.h

Yes, this one is OK with me too.

Thanks,
--
Jean Delvare
