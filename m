Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264419AbUEMSii@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264419AbUEMSii (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 14:38:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264413AbUEMSfz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 14:35:55 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:16044 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264386AbUEMSdH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 14:33:07 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Andrew Gusev <ronne@list.ru>
Subject: Re: Bug in IDE/ATAPI CDROM DRIVER
Date: Thu, 13 May 2004 20:33:59 +0200
User-Agent: KMail/1.5.3
References: <40A3BD4E.5050900@list.ru>
In-Reply-To: <40A3BD4E.5050900@list.ru>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405132033.59951.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is ACPI bug not IDE/ATAPI one.

boot with "acpi=noirq" as workaround and contact ACPI maintainer :-)

Cheers.

On Thursday 13 of May 2004 20:24, Andrew Gusev wrote:
> Hello Jens Axboe,
> I'm try to report bug.
>
> [1.] ide-cd: cmd 0x5a timed out, hdd: lost interrupt
> [2.] I'm have configuration file from good working kernel 2.6.5.

