Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751165AbWCZIDM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751165AbWCZIDM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 03:03:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751167AbWCZIDM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 03:03:12 -0500
Received: from isilmar.linta.de ([213.239.214.66]:22160 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S1751165AbWCZIDL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 03:03:11 -0500
Date: Sun, 26 Mar 2006 10:00:10 +0200
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC: 2.6 patch] the overdue removal of drivers/pcmcia/pcmcia_ioctl.c
Message-ID: <20060326080010.GC8572@dominikbrodowski.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
References: <20060324014634.GU22727@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060324014634.GU22727@stusta.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2006 at 02:46:34AM +0100, Adrian Bunk wrote:
> This patch contains the overdue removal of drivers/pcmcia/pcmcia_ioctl.c 
> plus the fallout of additional cleanups after this removal.
> 
> This patch contains the scheduled removal of 
> drivers/pcmcia/pcmcia_ioctl.c plus the fallout of additional cleanups 
> after this removal.

Vetoed. I'll push the pcmcia_ioctl.c removal when the few remaining issues
with the new pcmciautils interface are solved.

	Dominik
