Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265168AbTLFNpl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 08:45:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265169AbTLFNpl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 08:45:41 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:47542 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S265168AbTLFNpk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 08:45:40 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Craig Bradney <cbradney@zip.com.au>, Ian Kumlien <pomac@vapor.com>
Subject: Re: Catching NForce2 lockup with NMI watchdog - found?
Date: Sat, 6 Dec 2003 14:47:13 +0100
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <1070676480.1989.15.camel@big.pomac.com> <1070717770.13004.11.camel@athlonxp.bradney.info>
In-Reply-To: <1070717770.13004.11.camel@athlonxp.bradney.info>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312061447.13615.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 06 of December 2003 14:36, Craig Bradney wrote:

> nVIDIA nForce2 (10de 01e0) found
> 'Halt Disconnect and Stop Grant Disconnect' bit is enabled.
>
> Do others have the same value 10de 01e0 when they run athcool stat? Even
> with the same motherboard (a7n8x deluxe)?

Yes.

0x10de is a PCI VendorID (nVidia).
0x01e0 is a PCI DeviceID (nForce2).

;-)

--bart

