Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750801AbWANTM6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750801AbWANTM6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 14:12:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750815AbWANTM6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 14:12:58 -0500
Received: from fisek2.ada.net.tr ([195.112.153.19]:29351 "EHLO
	mail.fisek.com.tr") by vger.kernel.org with ESMTP id S1750801AbWANTM5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 14:12:57 -0500
X-Mail-Scanner: Scanned by qSheff 1.0 (http://www.enderunix.org/qsheff/)
Date: Sat, 14 Jan 2006 21:12:42 +0200
From: Onur =?UTF-8?B?S8O8w6fDvGs=?= <onur@delipenguen.net>
To: Joshua Kwan <joshk@triplehelix.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [?] PCI BIOS masks some IDs to prevent OS detection?
Message-Id: <20060114211242.b8ffaddb.onur@delipenguen.net>
In-Reply-To: <20060113144529.56fa3166@darjeeling.triplehelix.org>
References: <20060113144529.56fa3166@darjeeling.triplehelix.org>
X-Mailer: Sylpheed version 2.2.0beta4 (GTK+ 2.8.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> He recently installed a PCI RAID card, and ever since, his Ethernet
> card stopped working. Further investigation revealed that his
> Realtek 8139 (10ec:8139) card had become 10ec:0139, and his 3Com
> Cyclone card had become 10b7:1055 from 10b7:9055.
> 
> Did the PCI bus decide to mask those PCI IDs to prevent some sort of
> resource conflict that would ensue from loading an appropriate driver
> for these devices?

 Probably just 1 pin somewhere does not connect well to the board, if
it did not burn or got scratched. I once had a soundblaster turn into a
graphics card :) Make sure you plug in clean slots (clean the dust) and
plug the cards well.

-- 
 Onur Küçük                                      Knowledge speaks,   
 <onur.--.-.delipenguen.net>                     but wisdom listens  

