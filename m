Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751239AbVJFX0R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751239AbVJFX0R (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 19:26:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751229AbVJFX0R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 19:26:17 -0400
Received: from [64.162.99.240] ([64.162.99.240]:2262 "EHLO
	spamtest2.viacore.net") by vger.kernel.org with ESMTP
	id S1751239AbVJFX0R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 19:26:17 -0400
Message-ID: <4345B218.3040309@spamtest.viacore.net>
Date: Thu, 06 Oct 2005 16:24:08 -0700
From: Joe Bob Spamtest <joebob@spamtest.viacore.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050923 Fedora/1.7.12-1.5.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: what's next for the linux kernel?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc Perkel wrote:
> Right - that's Unix "inside the box" thinking. The idea is to make the 
> operating system smarter so that the user doesn't have to deal with 
> what's computer friendly - but reather what makes sense to the user. 
>  From a user's perspective if you have not rights to access a file then 
> why should you be allowed to delete it?

then that file shouldn't be in a directory owned by $otheruser.

> Now - the idea is to create choice. If you need to emulate Unix nehavior 
> for compatibility that's fine. But I would migrate away from that into a 
> permissions paradygme that worked like Netware.

the word is 'paradigm.' anyhow, through posix acls and selinux you can
achieve the behaviour you so love.

> I started with Netware and I'm spoiled. They had it right 15 years ago 
> and Linux isn't any where near what I was with Netware and DOS in 1990. 
> Once you've had this kind of permission power Linux is a real big step 
> down.

if you like netware so much, then fucking use it. nobody here will stop you.

> So - the thread is about the future so I say - time to fix Unix.

UNIX isn't broken. you're just not asking it to do the right things.

