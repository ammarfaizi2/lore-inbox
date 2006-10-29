Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932144AbWJ2J5J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932144AbWJ2J5J (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 04:57:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932146AbWJ2J5J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 04:57:09 -0500
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:16531 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S932144AbWJ2J5H
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 04:57:07 -0500
Message-ID: <45447AF1.7090208@drzeus.cx>
Date: Sun, 29 Oct 2006 10:57:05 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.7 (X11/20061008)
MIME-Version: 1.0
To: Carlos Aguiar <carlos.aguiar@indt.org.br>
CC: linux-kernel@vger.kernel.org, linux-omap-open-source@linux.omap.com,
       David Brownell <david-b@pacbell.net>, Tony Lindgren <tony@atomide.com>,
       Russell King <rmk+lkml@arm.linux.org.uk>, ilias.biris@indt.org.br
Subject: Re: [patch 5/6] [RFC] Add MMC Password Protection (lock/unlock) support
 V5
References: <20061020164914.012378000@localhost.localdomain> <20061020165136.664879000@localhost.localdomain>
In-Reply-To: <20061020165136.664879000@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Carlos Aguiar wrote:
> Implement MMC password force erase, remove password, change password,
> unlock card and assign password operations. It uses the sysfs mechanism
> to send commands to the MMC subsystem. 
>   

There are some indentation problems with this patch.

Also, what's the difference between "change" and "assign"? The code
seems to do the same thing.

Rgds

-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org

