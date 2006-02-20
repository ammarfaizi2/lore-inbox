Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161066AbWBTRdM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161066AbWBTRdM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 12:33:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161070AbWBTRdL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 12:33:11 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:26048 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1161066AbWBTRdK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 12:33:10 -0500
Subject: Re: libata PATA drivers patch for 2.6.16-rc4
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Fabio Comolli <fabio.comolli@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <b637ec0b0602200742j5780bfcck75f9090c91b8760f@mail.gmail.com>
References: <1140445182.26526.1.camel@localhost.localdomain>
	 <b637ec0b0602200742j5780bfcck75f9090c91b8760f@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 20 Feb 2006 17:36:57 +0000
Message-Id: <1140457017.26526.26.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2006-02-20 at 16:42 +0100, Fabio Comolli wrote:
> Hi Alan.
> Does this version address the issue I pointed out some days ago (ICH4
> identified as only UDMA/66 capable)?

I'm still scratching my head over that one. Its on the todo list.
Actually one thought - can you send me an lspci -vxx


Alan

