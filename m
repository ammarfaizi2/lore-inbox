Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750792AbVJ3PUf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750792AbVJ3PUf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 10:20:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750839AbVJ3PUf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 10:20:35 -0500
Received: from fattire.cabal.ca ([134.117.69.58]:43727 "EHLO fattire.cabal.ca")
	by vger.kernel.org with ESMTP id S1750792AbVJ3PUe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 10:20:34 -0500
X-IMAP-Sender: kyle
Date: Sun, 30 Oct 2005 10:19:42 -0500
X-OfflineIMAP-x106197360-52656d6f746546617454697265-494e424f582e4f7574626f78: 1130685634-0845347258014-v4.0.11
From: Kyle McMartin <kyle@parisc-linux.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] schedule obsolete OSS drivers for removal
Message-ID: <20051030151942.GF6475@tachyon.int.mcmartin.ca>
References: <20051030105118.GW4180@stusta.de> <20051030142752.GE6475@tachyon.int.mcmartin.ca> <20051030151256.GZ4180@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051030151256.GZ4180@stusta.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 30, 2005 at 04:12:56PM +0100, Adrian Bunk wrote:
> ALSA bugs [1] #1301 and #1302 are still open.
>

Am I doing something wrong? Those look to be AD1816 bugs, not AD1889.
AD1816 is an ISA sound card. AD1889 is a PCI sound card only found on 
PA-RISC workstations.
 
> If they are resolved, SOUND_AD1889 will part of the next batch of OSS 
> driver removal a few months from now.
