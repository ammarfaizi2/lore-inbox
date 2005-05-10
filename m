Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261633AbVEJM65@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261633AbVEJM65 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 08:58:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261634AbVEJM64
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 08:58:56 -0400
Received: from zone4.gcu-squad.org ([213.91.10.50]:20204 "EHLO
	zone4.gcu-squad.org") by vger.kernel.org with ESMTP id S261633AbVEJM6y convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 08:58:54 -0400
Date: Tue, 10 May 2005 14:51:46 +0200 (CEST)
To: ladis@linux-mips.org
Subject: Re: [PATCH] ds1337: export ds1337_do_command
X-IlohaMail-Blah: khali@localhost
X-IlohaMail-Method: mail() [mem]
X-IlohaMail-Dummy: moo
X-Mailer: IlohaMail/0.8.14 (On: webmail.gcu.info)
Message-ID: <JbaRtloW.1115729506.5440950.khali@localhost>
In-Reply-To: <20050510121814.GB2492@orphique>
From: "Jean Delvare" <khali@linux-fr.org>
Bounce-To: "Jean Delvare" <khali@linux-fr.org>
CC: "James Chapman" <jchapman@katalix.com>,
       "LKML" <linux-kernel@vger.kernel.org>,
       "LM Sensors" <sensors@Stimpy.netroedge.com>, "Greg KH" <gregkh@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Ladislav,

> Export ds1337_do_command so it could be used also if driver is built as
> module.

Great, now we can apply the previous patch (changing the
ds1337_do_command parameters) and this one on top of it.

Thanks for your continued work on the ds1337 driver, this is much
appreciated.

--
Jean Delvare
