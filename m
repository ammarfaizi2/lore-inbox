Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262040AbSKMQgS>; Wed, 13 Nov 2002 11:36:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262046AbSKMQgS>; Wed, 13 Nov 2002 11:36:18 -0500
Received: from air-2.osdl.org ([65.172.181.6]:61096 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S262040AbSKMQgR>;
	Wed, 13 Nov 2002 11:36:17 -0500
Date: Wed, 13 Nov 2002 08:37:10 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Jeff Garzik <jgarzik@pobox.com>
cc: <vda@port.imtp.ilyichevsk.odessa.ua>, "David S. Miller" <davem@redhat.com>,
       Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
       <linux-kernel@vger.kernel.org>,
       Alexander Vlasenko <intrnl_edu@ilyichevsk.odessa.ua>
Subject: Re: dmesg of 2.5.45 boot on NFS client
In-Reply-To: <3DD28036.5010607@pobox.com>
Message-ID: <Pine.LNX.4.33L2.0211130836430.31388-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Nov 2002, Jeff Garzik wrote:

| Randy.Dunlap wrote:
|
| > On Wed, 13 Nov 2002, Jeff Garzik wrote:
| >
| > | Addressing only this specific issue, and not the larger $thread issue...
| > |
| > | Depends on what driver and version you are using.  It is preferred these
| > | days to force the media using ethtool.
| >
| > That's news to me.  "preferred" by whom?  certainly not by real users ??
| > It should just work.
|
|
| You missed quoting the operation he was performing:  forcing the media
| using mii-tool.  He was forcing the media type by hand.  It's impossible
| for that to just-work.
|
| I wasn't talking about setting media in general...

Thanks.  I misread your statement then.

-- 
~Randy
  "I read part of it all the way through." -- Samuel Goldwyn

