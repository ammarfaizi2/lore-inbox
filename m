Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267175AbUG1O2R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267175AbUG1O2R (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 10:28:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267184AbUG1O2Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 10:28:16 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:1482 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S267175AbUG1O2N
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 10:28:13 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Alan Cox <alan@redhat.com>
Subject: Re: PATCH: Add support for Innovision DM-8401H
Date: Wed, 28 Jul 2004 16:34:53 +0200
User-Agent: KMail/1.5.3
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
References: <20040728134910.GA8514@devserv.devel.redhat.com> <200407281610.54961.bzolnier@elka.pw.edu.pl> <20040728140846.GA23938@devserv.devel.redhat.com>
In-Reply-To: <20040728140846.GA23938@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200407281634.53664.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 28 of July 2004 16:08, Alan Cox wrote:
> On Wed, Jul 28, 2004 at 04:10:54PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > On Wednesday 28 of July 2004 15:49, Alan Cox wrote:
> > > This is an SII 680 with strange PCI identifiers it appears
> >
> > No, this is a different chipset (produced by ITE).
>
> Ok then its a different chipset produced by ITE which appears to work
> perfectly with the SII driver, rather like the different chipset produced
> by Adaptec that is bug compatible and register identical with the SI3112
>
> > I asked you to compare Sil and ITE datasheets
> > (as I don't have one for Sil0680).
> >
> > Have you done this?
>
> I don't have the ITE datasheet.

google is your friend: "IT8212F .pdf"

