Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751348AbWG0WBP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751348AbWG0WBP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 18:01:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751358AbWG0WBP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 18:01:15 -0400
Received: from mail29.messagelabs.com ([216.82.249.147]:3974 "HELO
	mail29.messagelabs.com") by vger.kernel.org with SMTP
	id S1751348AbWG0WBO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 18:01:14 -0400
X-VirusChecked: Checked
X-Env-Sender: Scott_Kilau@digi.com
X-Msg-Ref: server-14.tower-29.messagelabs.com!1154037673!29497964!1
X-StarScan-Version: 5.5.10.7; banners=-,-,-
X-Originating-IP: [66.77.174.21]
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Problems with Digi Etherlite Dirver
Date: Thu, 27 Jul 2006 17:01:12 -0500
Message-ID: <335DD0B75189FB428E5C32680089FB9F803B09@mtk-sms-mail01.digi.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: RE: Problems with Digi Etherlite Dirver
Thread-Index: AcaxyCzBW+9JQYdCSf6ygGiWBdw90g==
From: "Kilau, Scott" <Scott_Kilau@digi.com>
To: <pgallen@gmail.com>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 27 Jul 2006 22:01:13.0319 (UTC) FILETIME=[2D000770:01C6B1C8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> /usr/src/redhat/BUILD/dgrp-1.9/driver/dgrp_net_ops.c:453: error:
> 'struct tty_struct' has no member named 'flip'

> The driver works in FC3 and FC4. Since I have the source for the
> driver, my question is what has changed in the kernel and where do I
> look (in the kernel) to find what to change to make the driver
> compatible with FC5?

Hi Paul,

The tty layer in the kernel has changed in 2.6.16+.

Digi has the problem fixed, you just need an updated driver
from us.

You should contact the support group at support@digi.com who will
be able to send you the new source rpm for your Etherlite.

Scott Kilau
Digi International



