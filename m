Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751172AbWJWCIx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751172AbWJWCIx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 22:08:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751168AbWJWCIx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 22:08:53 -0400
Received: from de01egw02.freescale.net ([192.88.165.103]:43723 "EHLO
	de01egw02.freescale.net") by vger.kernel.org with ESMTP
	id S1751161AbWJWCIw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 22:08:52 -0400
Subject: Re: [patch 3/3] Add tsi108 On Chip Ethernet device driver support
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Roland Dreier <rdreier@cisco.com>, Andrew Morton <akpm@osdl.org>,
       netdev <netdev@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "Alexandre.Bounine@tundra.com" <Alexandre.Bounine@tundra.com>
In-Reply-To: <45121924.4000200@pobox.com>
References: <A0CDBA58F226D911B202000BDBAD46730A1B1410@zch01exm23.fsl.freescale.net>
	 <1157962200.10526.10.camel@localhost.localdomain>
	 <1158051351.14448.97.camel@localhost.localdomain>
	 <ada3bax2lzw.fsf@cisco.com>  <4506C789.4050404@pobox.com>
	 <1158749825.7973.9.camel@localhost.localdomain>
	 <45121924.4000200@pobox.com>
Content-Type: text/plain
Organization: 
Message-Id: <1161569363.23698.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 23 Oct 2006 10:09:23 +0800
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 Oct 2006 02:08:47.0763 (UTC) FILETIME=[2CE08E30:01C6F648]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-09-21 at 12:46, Jeff Garzik wrote:

> you should have a chip structure, that contains two structs (one for 
> each interface/port)
> 
Jeff,

I updated the code according to all your feedback and post it here

http://www.spinics.net/lists/netdev/msg17120.html

Any comment?

Roy

