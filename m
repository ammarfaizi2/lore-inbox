Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262361AbUC1TSB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 14:18:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262382AbUC1TSB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 14:18:01 -0500
Received: from dream.estpak.ee ([194.126.115.147]:30848 "EHLO arena.estpak.ee")
	by vger.kernel.org with ESMTP id S262361AbUC1TR6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 14:17:58 -0500
From: Hasso Tepper <hasso@estpak.ee>
To: Phil Oester <kernel@linuxace.com>
Subject: Re: Kernel panic in 2.4.25
Date: Sun, 28 Mar 2004 22:17:54 +0300
User-Agent: KMail/1.6.2
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, linux-net@vger.kernel.org
References: <200403260035.09821.hasso@estpak.ee> <200403282033.16204.hasso@estpak.ee> <20040328182522.GA22382@linuxace.com>
In-Reply-To: <20040328182522.GA22382@linuxace.com>
MIME-Version: 1.0
Content-Disposition: inline
Organization: Elion Enterprises Ltd.
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200403282217.54539.hasso@estpak.ee>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Phil Oester wrote:
> Do you have CONFIG_IP_MULTICAST enabled in your .config?

Yes.

> I don't, and a couple of the changes in this changeset depend upon
> it. 
>
> I also run ospfd, so maybe you've hit upon something here...cc'ing
> linux-net for comment

-- 
Hasso Tepper
Elion Enterprises Ltd.
WAN administrator
