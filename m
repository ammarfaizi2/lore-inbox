Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265081AbUD3QAM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265081AbUD3QAM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 12:00:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265097AbUD3QAM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 12:00:12 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:15341 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S265081AbUD3P7n
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 11:59:43 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: CaT <cat@zip.com.au>
Subject: Re: libata + siI3112 + 2.6.5-rc3 hang
Date: Fri, 30 Apr 2004 18:00:08 +0200
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>
References: <20040429234258.GA6145@zip.com.au> <200404300208.32830.bzolnier@elka.pw.edu.pl> <20040430093919.GA2109@zip.com.au>
In-Reply-To: <20040430093919.GA2109@zip.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404301800.08763.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 30 of April 2004 11:39, CaT wrote:
> On Fri, Apr 30, 2004 at 02:08:32AM +0200, Bartlomiej Zolnierkiewicz wrote:
> > Probably your drive needs mod15write quirk. please try this.
> >
> > [PATCH] sata_sil.c: ST3200822AS needs MOD15WRITE quirk
>
> Didn't work. Still hangs rather well. :/

I have no idea then.   Jeff?

