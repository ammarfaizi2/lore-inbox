Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262112AbSKMQ2E>; Wed, 13 Nov 2002 11:28:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262128AbSKMQ2D>; Wed, 13 Nov 2002 11:28:03 -0500
Received: from air-2.osdl.org ([65.172.181.6]:47780 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S262112AbSKMQ2C>;
	Wed, 13 Nov 2002 11:28:02 -0500
Date: Wed, 13 Nov 2002 08:29:13 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Jeff Garzik <jgarzik@pobox.com>
cc: <vda@port.imtp.ilyichevsk.odessa.ua>, "David S. Miller" <davem@redhat.com>,
       Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
       <linux-kernel@vger.kernel.org>,
       Alexander Vlasenko <intrnl_edu@ilyichevsk.odessa.ua>
Subject: Re: dmesg of 2.5.45 boot on NFS client
In-Reply-To: <3DD27C0C.70506@pobox.com>
Message-ID: <Pine.LNX.4.33L2.0211130827590.31388-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Nov 2002, Jeff Garzik wrote:

| Addressing only this specific issue, and not the larger $thread issue...
|
| Depends on what driver and version you are using.  It is preferred these
| days to force the media using ethtool.

That's news to me.  "preferred" by whom?  certainly not by real users ??
It should just work.

| But that said, if a NIC driver
| allows you to force in 2.4 and not in 2.5, that definitely sounds like
| an eth driver bug.

-- 
~Randy
  "I read part of it all the way through." -- Samuel Goldwyn

