Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272445AbTHMMVc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 08:21:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272450AbTHMMVc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 08:21:32 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:26857 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S272445AbTHMMVb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 08:21:31 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Jan Niehusmann <jan@gondor.com>
Subject: Re: IDE bug - was: Re: uncorrectable ext2 errors
Date: Wed, 13 Aug 2003 14:21:32 +0200
User-Agent: KMail/1.5
Cc: Andries Brouwer <aebr@win.tue.nl>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030806150335.GA5430@gondor.com> <200308130221.26305.bzolnier@elka.pw.edu.pl> <20030813080309.GB2006@gondor.com>
In-Reply-To: <20030813080309.GB2006@gondor.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308131421.32450.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 13 of August 2003 10:03, Jan Niehusmann wrote:
>
> By the way: That computer reports a
> 00:11.0 RAID bus controller: Promise Technology, Inc. 20265 (rev 02)
> while the server has a
> 00:11.0 Unknown mass storage controller: Promise Technology, Inc. 20265
> (rev 02)
>
> (Numeric Class IDs are 0104 and respectively 0180, vendor and device
> codes are the same on both computers)
>
> Do you think this will make any difference? IIRC, the FastTrack series
> has some RAID features, but you can safely ignore them and use it
> just as a simple ATA100 controller.

Just remember to say Y to "Special FastTrak feature".

--bartlomiej

