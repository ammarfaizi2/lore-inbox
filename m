Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261415AbUBYUCU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 15:02:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261304AbUBYUCS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 15:02:18 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:60383 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261287AbUBYUCN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 15:02:13 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Phil Thompson <phil@riverbankcomputing.co.uk>
Subject: [PATCH] ATI IXP IDE support (was: Re: Support for ATI IXP150 Southbridge)
Date: Wed, 25 Feb 2004 21:08:37 +0100
User-Agent: KMail/1.5.3
Cc: Matthew Tippett <mtippett@ati.com>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
References: <200402232123.43989.phil@riverbankcomputing.co.uk> <200402232354.42308.bzolnier@elka.pw.edu.pl> <200402241808.22246.phil@riverbankcomputing.co.uk>
In-Reply-To: <200402241808.22246.phil@riverbankcomputing.co.uk>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200402252108.37225.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 24 of February 2004 19:08, Phil Thompson wrote:
> On Monday 23 February 2004 22:54, Bartlomiej Zolnierkiewicz wrote:
> > On Monday 23 of February 2004 22:23, Phil Thompson wrote:
> > > Is anybody working on support for the ATI IXP150 Southbridge?
> > > Particularly the IDE and USB devices.
> >
> > IDE support should be added soon (thanks to ATI).
> >
> > --bart
>
> Great - is there someone I can contact to volunteer to help with testing?

You can find experimental (I have not tested it!) driver for 2.6.3 kernel at:
http://www.kernel.org/pub/linux/kernel/people/bart/atiixp_ide/atiixp_ide-2.6.3-1.patch

It was written by Hui Yu <hyu@ati.com>, additional fixes/cleanups by me.

Thanks,
--bart

