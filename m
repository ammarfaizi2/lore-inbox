Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264323AbTLBT0S (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 14:26:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264330AbTLBT0S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 14:26:18 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:16381 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264323AbTLBTZN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 14:25:13 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Andrew Ryan <genanr@emsphone.com>
Subject: Re: ide-cd 2.6.0-test11 does not work
Date: Tue, 2 Dec 2003 20:26:47 +0100
User-Agent: KMail/1.5.4
References: <20031202163856.GA16759@thumper2.emsphone.com>
In-Reply-To: <20031202163856.GA16759@thumper2.emsphone.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312022026.47485.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Do you have IDE CD support compiled-in or as module (ide-cd)?

--bart

On Tuesday 02 of December 2003 17:38, Andrew Ryan wrote:
> The docs say I shouldn't need ide-scsi anymore, but ide-scsi is the only
> way I can mount cds.  If I try mount /dev/hdc /mnt I get /dev/hdc is not a
> valid block device.  After loading ide-scsi, mount /dev/sr0 /mnt works fine
> (though if I rip music cds with xcdroast the system locks up, ide-scsi
> related oops).  This is on a hp zd7000 notebook with a dvd/cd-rw
> (HL-DT-STCD-RW/DVD DRIVE GCC-4241N).

