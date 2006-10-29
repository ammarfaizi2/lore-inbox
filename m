Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932152AbWJ2J5p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932152AbWJ2J5p (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 04:57:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932153AbWJ2J5p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 04:57:45 -0500
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:16531 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S932152AbWJ2J5o
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 04:57:44 -0500
Message-ID: <45447B16.10708@drzeus.cx>
Date: Sun, 29 Oct 2006 10:57:42 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.7 (X11/20061008)
MIME-Version: 1.0
To: Carlos Aguiar <carlos.aguiar@indt.org.br>
CC: linux-kernel@vger.kernel.org, linux-omap-open-source@linux.omap.com,
       David Brownell <david-b@pacbell.net>, Tony Lindgren <tony@atomide.com>,
       Russell King <rmk+lkml@arm.linux.org.uk>, ilias.biris@indt.org.br
Subject: Re: [patch 6/6] [RFC] Add MMC Password Protection (lock/unlock) support
 V5
References: <20061020164914.012378000@localhost.localdomain> <20061020165139.911232000@localhost.localdomain>
In-Reply-To: <20061020165139.911232000@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Carlos Aguiar wrote:
> Removes an unused function: mmc_omap_switch_callback() and
> changed IRQ comparison in omap.c
>   

This looks completely unrelated to password support.

Rgds

-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org

