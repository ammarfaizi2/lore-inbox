Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751511AbWFLSFv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751511AbWFLSFv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 14:05:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751005AbWFLSFu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 14:05:50 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:63974 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750802AbWFLSFu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 14:05:50 -0400
Date: Mon, 12 Jun 2006 20:05:49 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Ivo van Doorn <ivdoorn@gmail.com>
cc: "Randy.Dunlap" <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] CRC ITU-T V.41
In-Reply-To: <200606121932.37990.IvDoorn@gmail.com>
Message-ID: <Pine.LNX.4.61.0606122005060.7959@yvahk01.tjqt.qr>
References: <200606121617.08791.IvDoorn@gmail.com> <20060612100942.62ad4d0e.rdunlap@xenotime.net>
 <200606121932.37990.IvDoorn@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> so the rt2x00 driver will be converted to use this lib/ code?
>
>Yes. [...]
>If this patch is is applied I'll immediately send the patch to netdev
>to make rt2x00 use this library.
>
Is rt2x00 already in-kernel? AFAIK no, but correct me if I am wrong.



Jan Engelhardt
