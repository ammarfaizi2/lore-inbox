Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932074AbWIVKm3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932074AbWIVKm3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 06:42:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932081AbWIVKm3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 06:42:29 -0400
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:29837 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S932074AbWIVKm2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 06:42:28 -0400
Message-ID: <4513BE0D.30804@drzeus.cx>
Date: Fri, 22 Sep 2006 12:42:21 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Alex Dubov <oakad@yahoo.com>
CC: linux-kernel@vger.kernel.org, akpm@osdl.org, rmk+lkml@arm.linux.org.uk
Subject: Re: [PATCH 2/2 try 2] [MMC] Driver for TI FlashMedia card reader
 - Kconfig/Makefile
References: <20060922062632.61792.qmail@web36714.mail.mud.yahoo.com>
In-Reply-To: <20060922062632.61792.qmail@web36714.mail.mud.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Dubov wrote:
>  
> +config MMC_TIFM_SD
> +	tristate "TI Flash Media MMC/SD Interface support  (EXPERIMENTAL)"
> +	depends on MMC && EXPERIMENTAL
> +	select TIFM_CORE
>   

Two thumbs up. :)

Rgds
Pierre

