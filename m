Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263415AbUERO37@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263415AbUERO37 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 May 2004 10:29:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263435AbUERO37
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 May 2004 10:29:59 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:5034 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S263415AbUERO3z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 May 2004 10:29:55 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: "O.Sezer" <sezero@superonline.com>
Subject: Re: [PATCH 2.4] decrypt/update ide help entries
Date: Tue, 18 May 2004 16:31:16 +0200
User-Agent: KMail/1.5.3
Cc: marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org
References: <40A8F0E7.4000807@superonline.com> <200405181609.04045.bzolnier@elka.pw.edu.pl> <40AA1B20.3010205@superonline.com>
In-Reply-To: <40AA1B20.3010205@superonline.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-9"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200405181631.16308.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 18 of May 2004 16:18, O.Sezer wrote:
> Bartlomiej Zolnierkiewicz wrote:
> [...]
> Thanks for your patience.
>
> > BTW it needs to be split-up for old and new driver (hint, hint!).
>
> Why? Do you think that an admin may want to enable/disable it for
> Chipset-A/pdc-old and disable/enable it for chipset-B/pdc-new ?

dunno but it is easier to add help entries for *_OLD and *_NEW ;-)
or we can remove FIXME from Kconfig (2.6) instead

> Thanks;
> Özkan Sezer

