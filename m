Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261825AbTCQSuS>; Mon, 17 Mar 2003 13:50:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261826AbTCQSuR>; Mon, 17 Mar 2003 13:50:17 -0500
Received: from yossman.net ([209.162.234.20]:46864 "EHLO yossman.net")
	by vger.kernel.org with ESMTP id <S261825AbTCQSuQ>;
	Mon, 17 Mar 2003 13:50:16 -0500
Message-ID: <3E761B65.20408@yossman.net>
Date: Mon, 17 Mar 2003 14:00:53 -0500
From: Brian Davids <dlister@yossman.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030211
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Maciej Soltysiak <solt@dns.toxicfilms.tv>
CC: linux-kernel@vger.kernel.org
Subject: Re: Where did IPX on 2.5 go?
References: <Pine.LNX.4.51.0303171939220.15852@dns.toxicfilms.tv>
In-Reply-To: <Pine.LNX.4.51.0303171939220.15852@dns.toxicfilms.tv>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maciej Soltysiak wrote:
> Hi,
> 
> i tried to find IPX support in 2.5 via make menuconfig, it is not there.
> (or where it used to be)
> There is nothing about IPX also in .config but net/ipx files are there.
> 
> It is 2.5.64-bk12. Was it removed or i am missing something here.
> 
> Regards,
> Maciej

It's under Networking Support, Networking Options, ANSI/IEEE 802.0 - aka 
LLC (IPX, Appletalk, Token Ring).  Yeah it's a little more buried than 
before, but it's still there.


Brian Davids

