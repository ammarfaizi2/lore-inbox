Return-Path: <linux-kernel-owner+w=401wt.eu-S964920AbXADPfA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964920AbXADPfA (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 10:35:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964922AbXADPfA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 10:35:00 -0500
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:40215 "EHLO
	smtp.drzeus.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964920AbXADPe7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 10:34:59 -0500
Message-ID: <459D1EA2.5070208@drzeus.cx>
Date: Thu, 04 Jan 2007 16:34:58 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.9 (X11/20061223)
MIME-Version: 1.0
To: Philip Langdale <philipl@overt.org>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       John Gilmore <gnu@toad.com>
Subject: Re: [PATCH 2.6.19] mmc: Add support for SDHC cards (Take 5)
References: <459D15DC.1090303@overt.org>
In-Reply-To: <459D15DC.1090303@overt.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Philip Langdale wrote:
> Thanks to the generous donation of an SDHC card by John Gilmore, and the
> surprisingly enlightened decision by the SD Card Association to publish
> useful specs, I've been able to bash out support for SDHC. The changes
> are not too profound:
>
>   

Looks good. I'll queue up both patches for -mm.

-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org

