Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264256AbUHAAsn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264256AbUHAAsn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jul 2004 20:48:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264299AbUHAAsn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jul 2004 20:48:43 -0400
Received: from mail.dif.dk ([193.138.115.101]:50852 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S264256AbUHAAsf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jul 2004 20:48:35 -0400
Date: Sun, 1 Aug 2004 02:53:06 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, acme@conectiva.com.br
Subject: Re: [PATCH] drivers/net/wan/cycx_x25.c:189: warning: conflicting
 types for built-in function 'log2'
In-Reply-To: <20040731173832.451d4e9e.akpm@osdl.org>
Message-ID: <Pine.LNX.4.60.0408010246090.2660@dragon.hygekrogen.localhost>
References: <Pine.LNX.4.60.0408010225180.2660@dragon.hygekrogen.localhost>
 <20040731173832.451d4e9e.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 31 Jul 2004, Andrew Morton wrote:

> Jesper Juhl <juhl-lkml@dif.dk> wrote:
>>
>
> Your patches get random rejects.
>
>> Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
>
> Probably because of the format=flowed braindamage.
>
Ouch, sorry about that, I recently upgraded my pine version to 4.60 and 
was unaware that from that version and forward pine generates flowed text 
by default. I'll get that fixed up at once.


> I fixed this one up.
>
Thank you.  


--
Jesper Juhl <juhl-lkml@dif.dk>

