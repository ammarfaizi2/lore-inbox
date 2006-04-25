Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751358AbWDYTuh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751358AbWDYTuh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 15:50:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932231AbWDYTuh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 15:50:37 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:46739 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S932175AbWDYTug (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 15:50:36 -0400
Date: Tue, 25 Apr 2006 21:50:35 +0200
From: Martin Mares <mj@ucw.cz>
To: David Schwartz <davids@webmaster.com>
Cc: "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: Re: C++ pushback
Message-ID: <mj+md-20060425.194740.24822.atrey@ucw.cz>
References: <mj+md-20060425.085309.25473.atrey@ucw.cz> <MDEHLPKNGKAHNMBLJOLKEEGNLIAB.davids@webmaster.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKEEGNLIAB.davids@webmaster.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	Hahaha. So now, it's not good enough that they not ask you to do anything,
> they have to actively *prevent* you from choosing to waste time on their
> changes?

If you wish to interpret it that way, I won't prevent you :-)

Anyway -- what I meant is that even if somebody writes a patch changing
names to avoid collisions with C++, _merging_ such a patch could be
easily a waste of other people's time, especially when there is no
other advantage in merging such a patch (like if the reason is that
somebody wishes to port his closed-source driver to Linux [*]).

[*]: Not that I'm claiming that this is the case now, but it already
happened.

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
First law of socio-genetics: Celibacy is not hereditary.
