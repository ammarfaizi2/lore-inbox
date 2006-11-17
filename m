Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933657AbWKQQyt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933657AbWKQQyt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 11:54:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933712AbWKQQyt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 11:54:49 -0500
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:29078 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S933657AbWKQQys
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 11:54:48 -0500
Message-ID: <455DE961.9020109@drzeus.cx>
Date: Fri, 17 Nov 2006 17:54:57 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.7 (X11/20061027)
MIME-Version: 1.0
To: Marcin Juszkiewicz <openembedded@hrw.one.pl>
CC: linux-kernel@vger.kernel.org,
       Russell King - ARM Linux <linux@arm.linux.org.uk>,
       linux-arm-kernel@lists.arm.linux.org.uk
Subject: Re: [PATCH] trivial change for mmc/Kconfig: MMC_PXA does not mean
 only PXA255
References: <200611162239.12391.openembedded@hrw.one.pl>
In-Reply-To: <200611162239.12391.openembedded@hrw.one.pl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcin Juszkiewicz wrote:
> PXA MMC driver supports not only PXA255 but also PXA250 and newer ones
>
> Signed-off-by: Marcin Juszkiewicz <hrw@openembedded.org>
>   

Thanks. Applied.

Rgds

-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org

