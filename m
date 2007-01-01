Return-Path: <linux-kernel-owner+w=401wt.eu-S1753606AbXAARtz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753606AbXAARtz (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 12:49:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754453AbXAARtz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 12:49:55 -0500
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:40078 "EHLO
	smtp.drzeus.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753606AbXAARty (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 12:49:54 -0500
Message-ID: <459949C5.7010103@drzeus.cx>
Date: Mon, 01 Jan 2007 18:49:57 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.9 (X11/20061223)
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: Philip Langdale <philipl@overt.org>, linux-kernel@vger.kernel.org,
       John Gilmore <gnu@toad.com>
Subject: Re: [PATCH 2.6.19] mmc: Add support for SDHC cards
References: <458C22C0.1080307@vmware.com> <458C290B.4060003@overt.org> <20061228133652.GE3955@ucw.cz>
In-Reply-To: <20061228133652.GE3955@ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Would you describe what SDHC is? I know SD flash cards, and IIRC SDIO
> cards exist, with functionality such as bluetooth...? But SDHC?
>
>   

SDHC is short for "Secure Digital High Capacity". It's simply SD flash
cards than conform to a new version of the protocol, a version where
addressing is done on a sector (512 byte) basis instead of bytes.

Rgds

-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org

