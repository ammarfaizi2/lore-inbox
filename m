Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750710AbWIHJGp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750710AbWIHJGp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 05:06:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750730AbWIHJGp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 05:06:45 -0400
Received: from emailer.gwdg.de ([134.76.10.24]:29904 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1750710AbWIHJGo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 05:06:44 -0400
Date: Fri, 8 Sep 2006 11:05:54 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
cc: Victor Hugo <victor@vhugo.net>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] e-mail clients
In-Reply-To: <6bffcb0e0609080131g66d50e9dnb41f4c2d2da88cb7@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0609081104440.23701@yvahk01.tjqt.qr>
References: <4500B2FB.8050805@vhugo.net>  <Pine.LNX.4.61.0609080912270.22545@yvahk01.tjqt.qr>
  <6bffcb0e0609080024l6c58de2el98d7139821c92e7e@mail.gmail.com> 
 <Pine.LNX.4.61.0609081013450.22545@yvahk01.tjqt.qr>
 <6bffcb0e0609080131g66d50e9dnb41f4c2d2da88cb7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> you might even be able to use bash
>> itself! It is not very friendly though, esp. when it comes to attachments
>> or
>> MIME encoding.
>
> LOL :)
>
> Bash is a very universal tool - something like EmacsOS.

Except that it is not as bloated as emacs.

cat </dev/tcp/kernel.org/finger
echo -en "EHLO y\nMAIL FROM: a@b.com\nRCPT TO: d@e.com\n..."  \
	>/dev/tcp/mailer.localdomain/25


Jan Engelhardt
-- 
