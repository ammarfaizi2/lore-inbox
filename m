Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261349AbSIWUI5>; Mon, 23 Sep 2002 16:08:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261353AbSIWUI4>; Mon, 23 Sep 2002 16:08:56 -0400
Received: from p508879B5.dip.t-dialin.net ([80.136.121.181]:49107 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S261349AbSIWUIz>; Mon, 23 Sep 2002 16:08:55 -0400
Date: Mon, 23 Sep 2002 14:14:40 -0600 (MDT)
From: Thunder from the hill <thunder@lightweight.ods.org>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Linus Torvalds <torvalds@transmeta.com>
cc: Peter Rival <frival@zk3.dec.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [ALPHA] Compile fixes for alpha arch
In-Reply-To: <Pine.LNX.4.44.0209230852550.13675-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0209231411560.7827-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf/Steudnitz; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 23 Sep 2002, Linus Torvalds wrote:
> This is why I absolutely abhor attachments - they add zero value (over a 
> well-behaving mail app), and they make some things basically impossible to 
> do conveniently.

I'd say they add value -- try sending binaries inline, and watch them beat 
you up...

> Alternatively, if you use attachments, if the mailer doesn't re-code them 
> as something stupid (ie leaves the encoding as plain ascii), then that 
> works too.

Suggestion: since you use the shell to create patches, do the following:

receive mail, respond to mail, write text mails -> pine
send patches -> script (I have got an example here.)

Will work fine, and not corrupt your stuff unless you tell it to.

			Thunder
-- 
assert(typeof((fool)->next) == typeof(fool));	/* wrong */

