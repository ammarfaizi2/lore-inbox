Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266925AbUG1OJk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266925AbUG1OJk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 10:09:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267164AbUG1OJk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 10:09:40 -0400
Received: from mx1.redhat.com ([66.187.233.31]:34220 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266925AbUG1OJj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 10:09:39 -0400
Date: Wed, 28 Jul 2004 10:08:46 -0400
From: Alan Cox <alan@redhat.com>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Alan Cox <alan@redhat.com>, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: PATCH: Add support for Innovision DM-8401H
Message-ID: <20040728140846.GA23938@devserv.devel.redhat.com>
References: <20040728134910.GA8514@devserv.devel.redhat.com> <200407281610.54961.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200407281610.54961.bzolnier@elka.pw.edu.pl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2004 at 04:10:54PM +0200, Bartlomiej Zolnierkiewicz wrote:
> On Wednesday 28 of July 2004 15:49, Alan Cox wrote:
> > This is an SII 680 with strange PCI identifiers it appears
> No, this is a different chipset (produced by ITE).

Ok then its a different chipset produced by ITE which appears to work
perfectly with the SII driver, rather like the different chipset produced
by Adaptec that is bug compatible and register identical with the SI3112

> I asked you to compare Sil and ITE datasheets
> (as I don't have one for Sil0680).
> 
> Have you done this?

I don't have the ITE datasheet.

Alan

