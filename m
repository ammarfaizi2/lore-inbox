Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268014AbTBRUmt>; Tue, 18 Feb 2003 15:42:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268015AbTBRUmt>; Tue, 18 Feb 2003 15:42:49 -0500
Received: from AMarseille-201-1-6-77.abo.wanadoo.fr ([80.11.137.77]:21287 "EHLO
	zion.wanadoo.fr") by vger.kernel.org with ESMTP id <S268014AbTBRUmn>;
	Tue, 18 Feb 2003 15:42:43 -0500
Subject: Re: PATCH: kill more ioregs, add OUTBSYNC
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
In-Reply-To: <E18lCIx-0006Az-00@the-village.bc.nu>
References: <E18lCIx-0006Az-00@the-village.bc.nu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1045601583.570.60.camel@zion.wanadoo.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 18 Feb 2003 21:53:03 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-02-18 at 19:17, Alan Cox wrote:

> +	void (*OUTBSYNC)(u8 addr, unsigned long port);

This is the version without the drive parameter... This is
on purpose ?

Regards,
Ben.

