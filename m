Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264538AbUHJMOp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264538AbUHJMOp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 08:14:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264531AbUHJMOp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 08:14:45 -0400
Received: from jabberwock.ucw.cz ([81.31.5.130]:21725 "EHLO jabberwock.ucw.cz")
	by vger.kernel.org with ESMTP id S264538AbUHJMOW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 08:14:22 -0400
Date: Tue, 10 Aug 2004 14:14:12 +0200
From: Martin Mares <mj@ucw.cz>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: alan@lxorguk.ukuu.org.uk, James.Bottomley@steeleye.com, axboe@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Message-ID: <20040810121412.GA8883@kam.mff.cuni.cz>
References: <200408101019.i7AAJPH9012045@burner.fokus.fraunhofer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408101019.i7AAJPH9012045@burner.fokus.fraunhofer.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> This is a problem of the people who use UTF-8..... sorry, but when
> they are tought that moving to UTF-8 is without problems is is just wrong.

Well, but according to this argument using anything else than iso-8859-1
is just wrong. Strange. :-)

> N.B. This is not a bug in cdrecord but wrong expectations from the users.

I think that it is very reasonable to expect that a program honors the locale
settings or uses only ASCII characters.

(In this matter, I share your feelings, because I also have non-ASCII
characters in my name, but if I decide to print my name in its full
glory, I respect the locales and don't assume that all the world uses
iso-8859-2 as I do.)

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
"How I need a drink, alcoholic in nature, after the tough chapters involving quantum mechanics!" = \pi
