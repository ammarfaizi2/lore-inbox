Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265692AbTFXE52 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 00:57:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265693AbTFXE52
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 00:57:28 -0400
Received: from dp.samba.org ([66.70.73.150]:38315 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S265692AbTFXE51 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 00:57:27 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Subject: Re: [PATCH] proper allocation of hwif->io_ports resources 
In-reply-to: Your message of "Mon, 23 Jun 2003 23:45:43 +0200."
             <200306232345.43959.bzolnier@elka.pw.edu.pl> 
Date: Tue, 24 Jun 2003 14:14:56 +1000
Message-Id: <20030624051135.B2A1A2C01B@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <200306232345.43959.bzolnier@elka.pw.edu.pl> you write:
> +int ide_hwif_request_regions (ide_hwif_t *hwif)
....
> +void ide_hwif_release_regions (ide_hwif_t *hwif)
....

A little too much whitespace.  Other than that, looks fine at a brief
glance.

Thanks!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
