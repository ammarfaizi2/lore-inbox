Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268334AbUJOTdv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268334AbUJOTdv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 15:33:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268340AbUJOTdv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 15:33:51 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:34456 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268334AbUJOTds
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 15:33:48 -0400
Message-ID: <4170260D.9010905@pobox.com>
Date: Fri, 15 Oct 2004 15:33:33 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: akpm@osdl.org
CC: "John W. Linville" <linville@tuxdriver.com>, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, Donald Becker <becker@scyld.com>
Subject: Re: [patch 2.6.9-rc3] 3c59x: reload EEPROM values at rmmod for needy
 cards
References: <20040928145455.C12480@tuxdriver.com> <Pine.LNX.4.44.0409291253510.1746-100000@training.scyld.com> <20040930091407.A10417@tuxdriver.com> <20041007134601.B29517@tuxdriver.com> <20041008123955.E14378@tuxdriver.com>
In-Reply-To: <20041008123955.E14378@tuxdriver.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John W. Linville wrote:
> Enable reload of EEPROM values in reset at rmmod for cards that need
> it, similar to old EEPROM_NORESET flag but in reverse.
> 
> Signed-of-by: John W. Linville <linville@tuxdriver.com>

Andrew... ack/nak?

Seems OK to me, provided that it chills out in -mm for a while for 
people to test.

	Jeff


