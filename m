Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262089AbSKMQca>; Wed, 13 Nov 2002 11:32:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262100AbSKMQca>; Wed, 13 Nov 2002 11:32:30 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:17936 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S262089AbSKMQc3>;
	Wed, 13 Nov 2002 11:32:29 -0500
Message-ID: <3DD28036.5010607@pobox.com>
Date: Wed, 13 Nov 2002 11:39:18 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021018
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Randy.Dunlap" <rddunlap@osdl.org>
CC: vda@port.imtp.ilyichevsk.odessa.ua, "David S. Miller" <davem@redhat.com>,
       Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
       linux-kernel@vger.kernel.org,
       Alexander Vlasenko <intrnl_edu@ilyichevsk.odessa.ua>
Subject: Re: dmesg of 2.5.45 boot on NFS client
References: <Pine.LNX.4.33L2.0211130827590.31388-100000@dragon.pdx.osdl.net>
In-Reply-To: <Pine.LNX.4.33L2.0211130827590.31388-100000@dragon.pdx.osdl.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:

> On Wed, 13 Nov 2002, Jeff Garzik wrote:
>
> | Addressing only this specific issue, and not the larger $thread issue...
> |
> | Depends on what driver and version you are using.  It is preferred these
> | days to force the media using ethtool.
>
> That's news to me.  "preferred" by whom?  certainly not by real users ??
> It should just work.


You missed quoting the operation he was performing:  forcing the media 
using mii-tool.  He was forcing the media type by hand.  It's impossible 
for that to just-work.

I wasn't talking about setting media in general...

	Jeff



