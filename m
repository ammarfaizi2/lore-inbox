Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262620AbSI0Tvz>; Fri, 27 Sep 2002 15:51:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262622AbSI0Tvy>; Fri, 27 Sep 2002 15:51:54 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:29455 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S262620AbSI0Tvx>;
	Fri, 27 Sep 2002 15:51:53 -0400
Message-ID: <3D94B7F5.6030401@pobox.com>
Date: Fri, 27 Sep 2002 15:56:37 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
CC: Linus Torvalds <torvalds@transmeta.com>,
       Orinoco Development List <orinoco-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: Orinoco driver update
References: <20020927025227.GC1898@zax>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David,

This doesn't compile at all...  stuff like "static void 
orinoco_reset[...]" in orinoco.c being called from orinoco_pci.c could 
never hope to build...

Linus applied it... would you mind sending an update patch please?

	Jeff



