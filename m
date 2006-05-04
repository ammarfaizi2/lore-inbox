Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751424AbWEDHfW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751424AbWEDHfW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 03:35:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751430AbWEDHfW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 03:35:22 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:62391 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S1751424AbWEDHfV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 03:35:21 -0400
Subject: Re: sdio - ocr confusions
From: Marcel Holtmann <marcel@holtmann.org>
To: Maximus <john.maximus@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3634de740605030330t1e060362ibff0e247bfb805e5@mail.gmail.com>
References: <3634de740605030330t1e060362ibff0e247bfb805e5@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 04 May 2006 09:36:31 +0200
Message-Id: <1146728191.10368.13.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

>   im trying to develop and sdio driver modifying the existing SD card driver.
>   Im using an OMAP processor and a Wifi SDIO Card.

I am trying to get SDIO working with the SDHCI driver, but so far with
no success at all. Did you modify the OMAP driver or the mmc_core to add
support for SDIO. From my understanding no changes to any of the drivers
should be necessary.

Regards

Marcel


