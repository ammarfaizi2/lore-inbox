Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751209AbWFZMtk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751209AbWFZMtk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 08:49:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751213AbWFZMtk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 08:49:40 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:6556 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751209AbWFZMtj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 08:49:39 -0400
Subject: Re: [PATCH] fix quickcam messenger build (git9)
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>
In-Reply-To: <20060625182954.a557ffbd.rdunlap@xenotime.net>
References: <20060625182954.a557ffbd.rdunlap@xenotime.net>
Content-Type: text/plain
Date: Mon, 26 Jun 2006 09:49:31 -0300
Message-Id: <1151326171.3687.5.camel@praia>
Mime-Version: 1.0
X-Mailer: Evolution 2.7.2.1-4mdv2007.0 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Randy,

> header filename changed:
> drivers/media/video/usbvideo/quickcam_messenger.c:36:11: error: unable to open 'linux/usb_input.h'

Thanks. Andrew had already noticed this while at -mm tree and sent a
fix. I've asked Linus to pull it, and should be in mainstream shortly.

Cheers, 
Mauro.

