Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269485AbUI3Urb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269485AbUI3Urb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 16:47:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269505AbUI3UrQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 16:47:16 -0400
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:31685 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S269498AbUI3UpW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 16:45:22 -0400
From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
To: Alan Cox <alan@redhat.com>
Subject: Re: PATCH: (Test) it8212 driver for 2.6.9rc3
Date: Thu, 30 Sep 2004 22:45:18 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
References: <20040930184535.GA31197@devserv.devel.redhat.com> <200409302218.48115.bzolnier@elka.pw.edu.pl>
In-Reply-To: <200409302218.48115.bzolnier@elka.pw.edu.pl>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409302245.18866.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[ I was so shocked that I forgot about it ]

Please

- merge+describe needed IDE core changes
- fix coding style and whitespace damage
- kill useless DECLARE_ITE_DEV macro
- add __init to it8212_ide_init()

and I will _happily_ merge this driver into ide-dev-2.6.

Thanks,
Bartlomiej
