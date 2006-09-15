Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750892AbWIOGnt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750892AbWIOGnt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 02:43:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750894AbWIOGnt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 02:43:49 -0400
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:43404 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S1750884AbWIOGnt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 02:43:49 -0400
Message-ID: <450A4BA4.9050409@drzeus.cx>
Date: Fri, 15 Sep 2006 08:43:48 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.5 (X11/20060907)
MIME-Version: 1.0
To: Alex Dubov <oakad@yahoo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Support for TI FlashMedia (pci id 104c:8033, 104c:803b) flash
 card readers
References: <20060915021738.95207.qmail@web36715.mail.mud.yahoo.com>
In-Reply-To: <20060915021738.95207.qmail@web36715.mail.mud.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Dubov wrote:
> I wonder, was there any progress with the inclusion of tifm driver into kernel? Are there any
> additional issues to examine with respect to this?
>
>   

Not from my perspective. Follow the discussion with Greg in this thread
and put together a patch against the current git. Make sure you follow
the format of kernel patches and things will go smoothly. :)

Note that Russell still has the final say when it comes to MMC though.

Rgds
Pierre

