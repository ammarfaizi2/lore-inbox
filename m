Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965162AbVIAOrl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965162AbVIAOrl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 10:47:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965168AbVIAOrl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 10:47:41 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:42419 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S965162AbVIAOrk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 10:47:40 -0400
Date: Thu, 1 Sep 2005 16:48:12 +0200
From: Martin Mares <mj@ucw.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Zoltan Szecsei <zoltans@geograph.co.za>, linux-kernel@vger.kernel.org
Subject: Re: multiple independent keyboard kernel support
Message-ID: <20050901144812.GA3483@atrey.karlin.mff.cuni.cz>
References: <4316E5D9.8050107@geograph.co.za> <20050901122253.GA11787@midnight.suse.cz> <4316FD08.1070505@geograph.co.za> <20050901132409.GA29134@midnight.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050901132409.GA29134@midnight.suse.cz>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> Btw, Aivils Stoss created a nice way to make several X instances have
> separate keyboards - see the linux-console archives for the faketty
> driver.

I haven't looked recently, but when I tried that several years ago,
the biggest problem was to make two simultaneously running X servers
not switch off each other's video card I/O ports off :)

All other things looked solvable with a reasonably small effort.

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
There is no place like ~
