Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267481AbSLRXYn>; Wed, 18 Dec 2002 18:24:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267487AbSLRXYm>; Wed, 18 Dec 2002 18:24:42 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:24583 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S267481AbSLRXXv>; Wed, 18 Dec 2002 18:23:51 -0500
Date: Wed, 18 Dec 2002 23:31:46 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>, mikael.starvik@axis.com
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21-pre2
Message-ID: <20021218233146.A2399@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Marcelo Tosatti <marcelo@conectiva.com.br>, mikael.starvik@axis.com,
	lkml <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.50L.0212181721340.18764-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.50L.0212181721340.18764-100000@freak.distro.conectiva>; from marcelo@conectiva.com.br on Wed, Dec 18, 2002 at 05:22:50PM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> <mikael.starvik@axis.com>:
>   o CRIS architecture update for 2.4.21

This seems to include some strange stuff.

It reverts the s/extern __inline__/static __inline__/g changes
in include/asm-cris/ and adds a junk file in
arch/cris/drivers/bluetooth/bt.patch
