Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262414AbSKNEAZ>; Wed, 13 Nov 2002 23:00:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262430AbSKNEAZ>; Wed, 13 Nov 2002 23:00:25 -0500
Received: from pizda.ninka.net ([216.101.162.242]:7115 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262414AbSKNEAX>;
	Wed, 13 Nov 2002 23:00:23 -0500
Date: Wed, 13 Nov 2002 20:05:14 -0800 (PST)
Message-Id: <20021113.200514.09647794.davem@redhat.com>
To: rddunlap@osdl.org
Cc: jgarzik@pobox.com, vda@port.imtp.ilyichevsk.odessa.ua,
       acme@conectiva.com.br, linux-kernel@vger.kernel.org,
       intrnl_edu@ilyichevsk.odessa.ua
Subject: Re: dmesg of 2.5.45 boot on NFS client
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.33L2.0211130827590.31388-100000@dragon.pdx.osdl.net>
References: <3DD27C0C.70506@pobox.com>
	<Pine.LNX.4.33L2.0211130827590.31388-100000@dragon.pdx.osdl.net>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Randy.Dunlap" <rddunlap@osdl.org>
   Date: Wed, 13 Nov 2002 08:29:13 -0800 (PST)

   On Wed, 13 Nov 2002, Jeff Garzik wrote:
   
   | Addressing only this specific issue, and not the larger $thread issue...
   |
   | Depends on what driver and version you are using.  It is preferred these
   | days to force the media using ethtool.
   
   That's news to me.  "preferred" by whom?  certainly not by real users ??
   It should just work.
   
ethtool is the preferred way to modify any ethernet device parameter
whatsoever.  It is the king of net device APIs for such operations.

Franks a lot,
David S. Miller
davem@redhat.com
