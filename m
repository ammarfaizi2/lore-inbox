Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264919AbTGBKoY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 06:44:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264923AbTGBKoY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 06:44:24 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:11795 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S264919AbTGBKoX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 06:44:23 -0400
Date: Tue, 1 Jul 2003 18:26:05 +0200
From: Pavel Machek <pavel@ucw.cz>
To: David Ford <david+powerix@blue-labs.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: laptop w/ external keyboard misprint FYI
Message-ID: <20030701162605.GA6810@zaurus.ucw.cz>
References: <3EFC7716.8050804@blue-labs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EFC7716.8050804@blue-labs.org>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Kernel 2.5.73, first time I've used an external keyboard
> 
> When I plug my external Logitech keyboard into my laptop, (shared 
> keyboard/mouse port), dmesg output indicates a generic mouse was 
> attached instead of a keyboard.  The keyboard works, it's just the 
> dmesg info that's inaccurate.

Well, you have plugged keyboard into
*mouse* port. Its small miracle it works ;), and
it probably will not work in LILO. You
should use Y cabel and plug keyboard there.

-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

