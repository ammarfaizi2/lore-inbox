Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750721AbWDKKvh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750721AbWDKKvh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 06:51:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750730AbWDKKvh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 06:51:37 -0400
Received: from albireo.ucw.cz ([84.242.65.108]:11651 "EHLO albireo.ucw.cz")
	by vger.kernel.org with ESMTP id S1750721AbWDKKvh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 06:51:37 -0400
Date: Tue, 11 Apr 2006 12:51:31 +0200
From: Martin Mares <mj@ucw.cz>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Ramakanth Gunuganti <rgunugan@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: GPL issues
Message-ID: <mj+md-20060411.105010.10318.albireo@ucw.cz>
References: <20060411063127.97362.qmail@web54314.mail.yahoo.com> <9a8748490604110142j30b5986et4c02f06dd3754ca4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a8748490604110142j30b5986et4c02f06dd3754ca4@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> > 1. If an application is built on top of this modified
> > kernel, should the application be released under GPL?
> 
> No. Applications that merely use the services the kernel provides need
> not be GPL.

However, this doesn't necessarily apply to cases where the kernel
modifications just export internal kernel stuff to userspace. In such
cases, the userspace application is very likely to be a derived work
of the kernel, so GPL applies there as well.

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
"I don't give a damn for a man that can only spell a word one way." -- M. Twain
