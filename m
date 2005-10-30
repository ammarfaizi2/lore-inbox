Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751049AbVJ3O22@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751049AbVJ3O22 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 09:28:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751055AbVJ3O22
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 09:28:28 -0500
Received: from fattire.cabal.ca ([134.117.69.58]:2512 "EHLO fattire.cabal.ca")
	by vger.kernel.org with ESMTP id S1751042AbVJ3O21 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 09:28:27 -0500
X-IMAP-Sender: kyle
Date: Sun, 30 Oct 2005 09:27:52 -0500
X-OfflineIMAP-x412032614-52656d6f746546617454697265-494e424f582e4f7574626f78: 1130682510-0824069331762-v4.0.11
From: Kyle McMartin <kyle@parisc-linux.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] schedule obsolete OSS drivers for removal
Message-ID: <20051030142752.GE6475@tachyon.int.mcmartin.ca>
References: <20051030105118.GW4180@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051030105118.GW4180@stusta.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 30, 2005 at 11:51:18AM +0100, Adrian Bunk wrote:
> 
> This patch schedules obsolete OSS drivers (with ALSA drivers that support the
> same hardware) for removal.
>

I didn't see it here, but SOUND_AD1889 can definitely be removed
as well. The driver never worked properly to begin with. This was
ACK'd by the author last time this thread reared it's head.

Cheers,
	Kyle
