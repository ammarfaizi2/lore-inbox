Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932372AbWBYOT6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932372AbWBYOT6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 09:19:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932394AbWBYOT6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 09:19:58 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:10454 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932372AbWBYOT5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 09:19:57 -0500
Date: Sat, 25 Feb 2006 15:19:40 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: gene.heskett@verizononline.net
cc: Christoph Hellwig <hch@infradead.org>,
       James Ketrenos <jketreno@linux.intel.com>,
       NetDev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org,
       okir@suse.de
Subject: Re: [Announce] Intel PRO/Wireless 3945ABG Network Connection
In-Reply-To: <200602250549.47547.gene.heskett@verizon.net>
Message-ID: <Pine.LNX.4.61.0602251518200.31692@yvahk01.tjqt.qr>
References: <43FF88E6.6020603@linux.intel.com> <20060225084139.GB22109@infradead.org>
 <200602250549.47547.gene.heskett@verizon.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>If the modules crc changes, 
>it must do an instant disable of the transmitter functions and exit or 
>crash, thereby precluding any 'hot rodding' of the chipset.
>
Would not it be easiest to have the chipset enforce the acceptable bands? 
So that software can't switch the chipset to 1337 GHz no matter how hard 
you forward/reverse-engineer it.


Jan Engelhardt
-- 
