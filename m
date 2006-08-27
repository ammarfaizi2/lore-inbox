Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932213AbWH0R5d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932213AbWH0R5d (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 13:57:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932214AbWH0R5d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 13:57:33 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:31637 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932213AbWH0R5d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 13:57:33 -0400
Message-ID: <44F1DD09.6030300@garzik.org>
Date: Sun, 27 Aug 2006 13:57:29 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Gustavo_Guillermo_P=E9rez?= <gustavo@compunauta.com>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Can't enable DMA over ATA on Intel Chipset 2.6.16
References: <200608271239.32507.gustavo@compunauta.com>
In-Reply-To: <200608271239.32507.gustavo@compunauta.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gustavo Guillermo Pérez wrote:
> Hello list, I can't enable DMA on this chipset, even forcing with the options provided in kconfig.

Google around for combined mode, and/or set your BIOS to something other 
than legacy IDE mode.

	Jeff



