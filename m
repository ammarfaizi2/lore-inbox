Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751060AbWHTRqv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751060AbWHTRqv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 13:46:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751062AbWHTRqv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 13:46:51 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:6284 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751060AbWHTRqu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 13:46:50 -0400
Subject: Re: 2.6.18-rc4-mm2
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
In-Reply-To: <6bffcb0e0608200630h40d2b07v1db22d19753734be@mail.gmail.com>
References: <20060819220008.843d2f64.akpm@osdl.org>
	 <6bffcb0e0608200630h40d2b07v1db22d19753734be@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 20 Aug 2006 19:07:53 +0100
Message-Id: <1156097273.4051.19.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Sul, 2006-08-20 am 15:30 +0200, ysgrifennodd Michal Piotrowski:
> 0kB Cache?
> 
> hdc: ATAPI CD-ROM drive, 0kB Cache, UDMA(33)
> Uniform CD-ROM driver Revision: 3.20
> hdd: ATAPI CD-ROM drive, 0kB Cache, UDMA(33)

Zero means "unspecified", so unless this changed from other boots I
wouldn't worry

