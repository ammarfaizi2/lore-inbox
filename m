Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275003AbTHMN6H (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 09:58:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275050AbTHMN6H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 09:58:07 -0400
Received: from windsormachine.com ([206.48.122.28]:16006 "EHLO
	router.windsormachine.com") by vger.kernel.org with ESMTP
	id S275003AbTHMN56 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 09:57:58 -0400
Date: Wed, 13 Aug 2003 09:57:56 -0400 (EDT)
From: Mike Dresser <mdresser_l@windsormachine.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Realtek network card
In-Reply-To: <3F3A3773.5070108@pobox.com>
Message-ID: <Pine.LNX.4.56.0308130957120.10007@router.windsormachine.com>
References: <20030813133059.616f0faa.skraw@ithnet.com> <3F3A3773.5070108@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-scanner: scanned by Inflex 1.0.12.3 - (http://pldaniels.com/inflex/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Aug 2003, Jeff Garzik wrote:

> > 00:08.0 Ethernet controller: Realtek Semiconductor Co., Ltd.: Unknown device 8131 (rev 10)
> > 	Subsystem: Realtek Semiconductor Co., Ltd.: Unknown device 8139
>
>
> The subsystem device id seems to indicate 8139, so you probably just
> need to add pci ids to 8139too.c.
>
> 	Jeff

8139 - 8131 = 8, think he might have the same problem i had a while ago
that you found, where the card just wasn't inserted right, and one bit was
off?

Mike
