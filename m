Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751783AbWIGOyd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751783AbWIGOyd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 10:54:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751793AbWIGOyd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 10:54:33 -0400
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:64651 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S1751783AbWIGOyc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 10:54:32 -0400
Message-ID: <450032A8.3070005@drzeus.cx>
Date: Thu, 07 Sep 2006 16:54:32 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.5 (X11/20060803)
MIME-Version: 1.0
To: madhu chikkature <crmadhu210@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: SDIO card support in Linux
References: <f71aedf40608310804w75728559ma5fd317e16e94b56@mail.gmail.com>	 <44F73E37.6030602@drzeus.cx>	 <f71aedf40609051651k5d36d4fdkb6020685fc366983@mail.gmail.com>	 <44FE5AAC.6030607@drzeus.cx> <f71aedf40609061622i7853ed74oc21757dde559286e@mail.gmail.com>
In-Reply-To: <f71aedf40609061622i7853ed74oc21757dde559286e@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

madhu chikkature wrote:
> Hi Pierre,
>
> What is the kernel version this patch is taken againest?

It's against the git version (plus some of my pending patches, which is
why I said you should ignore the chunk problems in mmc_block.c)

Rgds
Pierre

