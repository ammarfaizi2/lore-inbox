Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269018AbRHHURS>; Wed, 8 Aug 2001 16:17:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269115AbRHHURI>; Wed, 8 Aug 2001 16:17:08 -0400
Received: from quattro.sventech.com ([205.252.248.110]:34319 "HELO
	quattro.sventech.com") by vger.kernel.org with SMTP
	id <S269018AbRHHUQw>; Wed, 8 Aug 2001 16:16:52 -0400
Date: Wed, 8 Aug 2001 16:17:03 -0400
From: Johannes Erdfelt <johannes@erdfelt.com>
To: linux-kernel@vger.kernel.org
Subject: Determine if card is in 32 or 64 bit PCI slot?
Message-ID: <20010808161703.Q21901@sventech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a 64 bit PCI card which will work in either a 32 bit or 64 bit
PCI slot.

I'd like to make the driver autodetect which kind of slot the card is
in and set the dma_mask correctly, but I can't seem to figure out how to
do this.

Is there a way to figure this out in 2.4?

JE

