Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263079AbUEFV3F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263079AbUEFV3F (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 17:29:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263085AbUEFV3F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 17:29:05 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:21169 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S263079AbUEFV3C
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 17:29:02 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Bob Gill <gillb4@telusplanet.net>
Subject: Re: hdc: lost interrupt ide-cd: cmd 0x3 timed out with 2.6.6-rc3-bk8
Date: Thu, 6 May 2004 23:28:07 +0200
User-Agent: KMail/1.5.3
References: <1083875341.4603.20.camel@localhost.localdomain>
In-Reply-To: <1083875341.4603.20.camel@localhost.localdomain>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405062328.07646.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


zero IDE changes in bk6 -> bk8 but a lot of ACPI / IRQ related

On Thursday 06 of May 2004 22:29, Bob Gill wrote:
> Hi.  I recently built 2.6.6-rc3-bk8.  The boot process stalls with
> ide-cd: cmd 0x5a timed out
> hdc: lost interrupt.
> hdc: lost interrupt.
> hdc: lost interrupt.
> hdc: lost interrupt.
> ide-cd: cmd 0x3 timed out
> ...
> There are no problems booting 2.6.6-rc3-bk6.

