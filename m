Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751012AbVKWP0i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751012AbVKWP0i (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 10:26:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751010AbVKWP0i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 10:26:38 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:35743 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1750999AbVKWP0h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 10:26:37 -0500
Date: Wed, 23 Nov 2005 16:27:38 +0100
From: Martin Mares <mj@ucw.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Jon Smirl <jonsmirl@gmail.com>, Greg KH <greg@kroah.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Christmas list for the kernel
Message-ID: <20051123152738.GA30117@atrey.karlin.mff.cuni.cz>
References: <9e4733910511221031o44dd90caq2b24fbac1a1bae7b@mail.gmail.com> <20051122204918.GA5299@kroah.com> <9e4733910511221313t4a1e3c67wc7b08160937eb5c5@mail.gmail.com> <20051123121726.GA7328@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051123121726.GA7328@ucw.cz>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> VESAfb can't ever be autoloaded.

Really?  Wouldn't be possible to detect the video mode number passed to
video.S during boot and if it's a graphics mode, load VESAfb?

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
Wanted: Schroedinger Cat. Dead or Alive.
