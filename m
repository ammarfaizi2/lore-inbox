Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313558AbSFXOTx>; Mon, 24 Jun 2002 10:19:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313563AbSFXOTw>; Mon, 24 Jun 2002 10:19:52 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:46866 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S313558AbSFXOTv>;
	Mon, 24 Jun 2002 10:19:51 -0400
Message-ID: <3D172A9D.2090904@mandrakesoft.com>
Date: Mon, 24 Jun 2002 10:20:13 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/00200205
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
CC: Frank Davis <fdavis@si.rr.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.24 : drivers/net/defxx.c
References: <Pine.GSO.3.96.1020624103237.22509E-100000@delta.ds2.pg.gda.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maciej W. Rozycki wrote:
 >  It's possible DEFPA is not limited to 32-bit addressing.  The board was
 > designed with Alpha in mind, so it's likely it can address more (and a
 > brief look at the driver reveals there is room for 48 bits of address in
 > descriptor entries).
 >
 >  Has anyone seen documentation for the board?


Until we find the docs, I think the patch is fair...

	Jeff



