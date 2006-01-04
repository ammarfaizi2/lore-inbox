Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965203AbWADR24@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965203AbWADR24 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 12:28:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965238AbWADR24
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 12:28:56 -0500
Received: from mail.linicks.net ([217.204.244.146]:20440 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S965203AbWADR2z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 12:28:55 -0500
From: Nick Warne <nick@linicks.net>
To: Jesper Juhl <jesper.juhl@gmail.com>
Subject: Re: 2.6.14.5 to 2.6.15 patch
Date: Wed, 4 Jan 2006 17:28:52 +0000
User-Agent: KMail/1.9
Cc: linux-kernel@vger.kernel.org
References: <200601041710.37648.nick@linicks.net> <9a8748490601040918p24674d86j132315e9c8875483@mail.gmail.com>
In-Reply-To: <9a8748490601040918p24674d86j132315e9c8875483@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601041728.52081.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 04 January 2006 17:18, Jesper Juhl wrote:

> > Is there one?
>
> No.
>
> What you do is you first revert the 2.6.14.5 patch so you are left
> with a 2.6.14 kernel, then you apply the 2.6.15 patch.
> For more info, please read Documentation/applying-patches.txt
> (http://sosdg.org/~coywolf/lxr/source/Documentation/applying-patches.txt)

I thought about doing it that way, but convinced myself it was too 
complicated.

I see it is the right way (whatever that is).

I went from 2.6.14 -> 2.6.14.2 -> .2-.3 -> .3-.4 -> .4-.5

I suppose I have to backtrack and revert all those patches in order?

Thanks.

Nick
-- 
"Person who say it cannot be done should not interrupt person doing it."
-Chinese Proverb
My quake2 project:
http://sourceforge.net/projects/quake2plus/
