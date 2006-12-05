Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937187AbWLEGkN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937187AbWLEGkN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 01:40:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937356AbWLEGkN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 01:40:13 -0500
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:39116 "EHLO
	smtp.drzeus.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937187AbWLEGkL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 01:40:11 -0500
Message-ID: <45751446.8010402@drzeus.cx>
Date: Tue, 05 Dec 2006 07:40:06 +0100
From: Pierre Ossman <drzeus-mmc@drzeus.cx>
User-Agent: Thunderbird 1.5.0.7 (X11/20061027)
MIME-Version: 1.0
To: Sascha Hauer <s.hauer@pengutronix.de>
CC: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
Subject: Re: mmc: pxamci compilation fix
References: <20061204102852.GC5046@localhost.localdomain>
In-Reply-To: <20061204102852.GC5046@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sascha Hauer wrote:
> Hi Pierre and all,
> 
> since commit fcaf71fd51f9cfc504455d3e19ec242e4b2073ed
> struct mmc_host does not have a dev field. Retrieve the device with
> mmc_dev() instead.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> 

Bad Greg ;)

Applied, thanks.

Rgds
-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org
