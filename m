Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270548AbRHISkN>; Thu, 9 Aug 2001 14:40:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270550AbRHISkD>; Thu, 9 Aug 2001 14:40:03 -0400
Received: from quattro.sventech.com ([205.252.248.110]:12552 "HELO
	quattro.sventech.com") by vger.kernel.org with SMTP
	id <S270548AbRHISju>; Thu, 9 Aug 2001 14:39:50 -0400
Date: Thu, 9 Aug 2001 14:40:01 -0400
From: Johannes Erdfelt <johannes@erdfelt.com>
To: linux-kernel@vger.kernel.org
Subject: struct page to 36 (or 64) bit bus address?
Message-ID: <20010809144000.B1575@sventech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a 64 bit PCI card which I'd like to do 64 bit DMA with. I have a
struct page, but I don't see an easy way of determining what the bus
address for that page is.

Is there a way to do it at all?

JE

