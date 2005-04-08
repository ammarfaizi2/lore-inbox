Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262787AbVDHKUV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262787AbVDHKUV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 06:20:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262785AbVDHKTA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 06:19:00 -0400
Received: from zone4.gcu-squad.org ([213.91.10.50]:39390 "EHLO
	zone4.gcu-squad.org") by vger.kernel.org with ESMTP id S262783AbVDHKNV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 06:13:21 -0400
Date: Fri, 8 Apr 2005 12:08:38 +0200 (CEST)
To: ladis@linux-mips.org
Subject: Re: [PATCH] ds1337 3/4
X-IlohaMail-Blah: khali@localhost
X-IlohaMail-Method: mail() [mem]
X-IlohaMail-Dummy: moo
X-Mailer: IlohaMail/0.8.14 (On: webmail.gcu.info)
Message-ID: <u5mZNEX1.1112954918.3200720.khali@localhost>
In-Reply-To: <20050407231848.GD27226@orphique>
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

> dev_{dbg,err} functions should print client's device name. data->id can
> be dropped from message, because device is determined by bus it hangs on
> (it has fixed address).

Looks OK to me.

Thanks,
--
Jean Delvare
