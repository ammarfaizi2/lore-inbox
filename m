Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262446AbUARSa1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jan 2004 13:30:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262794AbUARSa1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jan 2004 13:30:27 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:26576 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S262446AbUARSaX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jan 2004 13:30:23 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>,
       Andries.Brouwer@cwi.nl
Subject: Re: Making MO drive work with ide-cd
Date: Sun, 18 Jan 2004 19:34:10 +0100
User-Agent: KMail/1.5.3
Cc: der.eremit@email.de, axboe@suse.de, linux-kernel@vger.kernel.org
References: <UTC200401181718.i0IHI5F26519.aeb@smtp.cwi.nl> <400AC95D.8030201@backtobasicsmgmt.com>
In-Reply-To: <400AC95D.8030201@backtobasicsmgmt.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401181934.10157.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 18 of January 2004 18:58, Kevin P. Fleming wrote:
> Andries.Brouwer@cwi.nl wrote:
> > Don't know whether Jens really wants to bend ide-cd.c until
> > it also handles disks, but it smells like a hack.
>
> Is Jeff Garzik's libata ever going to support parallel ATA? If so,

It will happen, but don't expect it soon (a lot of work is needed).

> doesn't that handle this situation nicely, given that the SCSI sd module
> should already know how to handle SCSI MO drives?

