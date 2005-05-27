Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262574AbVE0UZY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262574AbVE0UZY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 16:25:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262575AbVE0UZN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 16:25:13 -0400
Received: from mms1.broadcom.com ([216.31.210.17]:44814 "EHLO
	MMS1.broadcom.com") by vger.kernel.org with ESMTP id S262574AbVE0UZH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 16:25:07 -0400
X-Server-Uuid: 146C3151-C1DE-4F71-9D02-C3BE503878DD
Subject: Re: [patch 2.6.12-rc5] tg3: add bcm5752 entry to pci.ids
From: "Michael Chan" <mchan@broadcom.com>
To: "David S. Miller" <davem@davemloft.net>
cc: linville@tuxdriver.com, linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       jgarzik@pobox.com
In-Reply-To: <20050527.123037.68041200.davem@davemloft.net>
References: <04132005193844.8474@laptop>
 <20050421165956.55bdcb14.davem@davemloft.net>
 <20050527184750.GB11592@tuxdriver.com>
 <20050527.123037.68041200.davem@davemloft.net>
Date: Fri, 27 May 2005 12:24:19 -0700
Message-ID: <1117221859.4310.6.camel@rh4>
MIME-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3)
X-WSS-ID: 6E895EFA2U42798052-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-05-27 at 12:30 -0700, David S. Miller wrote:

> I'll apply this, thanks John.
> 
> pci.ids needs several updates for tg3 in fact, and it
> also now needs entries for bnx2 as well.
> 

The bnx2 IDs are already in, probably from sourceforge. And the tg3 IDs
look reasonably complete to me.

So in the future, do we need to patch this file or just let sourceforge
take care of it?

