Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265545AbUGTE5w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265545AbUGTE5w (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 00:57:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265548AbUGTE5w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 00:57:52 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:518 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S265545AbUGTE5v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 00:57:51 -0400
Date: Tue, 20 Jul 2004 06:56:11 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Ian Leonard <ian@smallworld.cx>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SATA ata_piix
Message-ID: <20040720045611.GD1545@alpha.home.local>
References: <40FB990D.9060808@smallworld.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40FB990D.9060808@smallworld.cx>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Look on http://www.kernel.org/pub/linux/kernel/people/jgarzik/patchkits/2.4/
you'll find at the end 2.4.27-rc3-libata1.patch.

Please do send feedback to Jeff, he asked for some a few days ago and
unfortunately I don't have the machine to test anymore. I don't know if
others reported successs stories.

Cheers,
Willy

On Mon, Jul 19, 2004 at 10:49:01AM +0100, Ian Leonard wrote:
> Hi,
> 
> I need to build the ata_piix driver, CONFIG_SCSI_ATA_PIIX. This doesn't 
> appear to be in 2.4.26 or 2.4.27-rc3. Does anyone know where it is?
> 
> TIA.
> 
> -- 
> Ian Leonard
> 
> Please ignore spelling and punctuation - I did.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
