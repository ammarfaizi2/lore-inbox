Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262177AbVAIBX7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262177AbVAIBX7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 20:23:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262180AbVAIBX6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 20:23:58 -0500
Received: from mail.dif.dk ([193.138.115.101]:15597 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262177AbVAIBXx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 20:23:53 -0500
Date: Sun, 9 Jan 2005 02:35:25 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Maciej Soltysiak <solt2@dns.toxicfilms.tv>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Maybe 2.6.10.1 ?
In-Reply-To: <595522059.20050108112557@dns.toxicfilms.tv>
Message-ID: <Pine.LNX.4.61.0501090231190.4014@dragon.hygekrogen.localhost>
References: <595522059.20050108112557@dns.toxicfilms.tv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 Jan 2005, Maciej Soltysiak wrote:

> Hello,
> 
> Maybe we should release 2.6.10.1 with those security fixes,
> so people maintaining other trees like: -tiny, -ck, -grsec,
> release patches over the fixed ones. Users won't miss the
> fixes if they prefer some trees instead of vanilla.
> 
> What do you think?
> 
I'd suggest (and I'm a comlete nobody in this regard) that instead Linus 
takes the security fixes + whatever he and Andrew deems to be "obviously 
correct and with zero risk of causing trouble" from the current -bk and 
turns that into 2.6.11-rc1, then let that stew for 2 or 3 days, then 
unless someone sees something horribly wrong, release it as 2.6.11 - then 
take whatever else is in current -bk and adds it and then that'll be 
2.6.11-bk1 and we move on from there.

-- 
Jesper Juhl



