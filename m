Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932340AbWBFTy6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932340AbWBFTy6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 14:54:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932339AbWBFTy6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 14:54:58 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:20692 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932340AbWBFTy5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 14:54:57 -0500
Subject: Re: 2.6.16-rc1-mm2 pata driver confusion
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Harald Dunkel <harald.dunkel@t-online.de>
Cc: linux-kernel@vger.kernel.org, "Randy.Dunlap" <rdunlap@xenotime.net>,
       Ed Sweetman <safemode@comcast.net>, akpm@osdl.org
In-Reply-To: <43E7A4C0.4020209@t-online.de>
References: <Pine.LNX.4.58.0601250846210.29859@shark.he.net>
	 <43E3D103.70505@comcast.net>
	 <Pine.LNX.4.58.0602060836520.1309@shark.he.net>
	 <43E7A4C0.4020209@t-online.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 06 Feb 2006 19:56:40 +0000
Message-Id: <1139255800.10437.51.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2006-02-06 at 20:34 +0100, Harald Dunkel wrote:
> how it is _supposed_ to work? Is there a conflict between
> ata_piix and piix/mpiix? A short summary could be very helpfull
> to identify problems, and to reduce confusion.

MPIIX is totally different PCI identifiers so a different driver. It is
unrelated to any goings on here.

