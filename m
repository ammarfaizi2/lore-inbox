Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932215AbVH3Qk7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932215AbVH3Qk7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 12:40:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932216AbVH3Qk7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 12:40:59 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:54372
	"EHLO g5.random") by vger.kernel.org with ESMTP id S932215AbVH3Qk6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 12:40:58 -0400
Date: Tue, 30 Aug 2005 18:40:54 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Rogier Wolff <R.E.Wolff@BitWizard.nl>, Sven Ladegast <sven@linux4geeks.de>,
       linux-kernel@vger.kernel.org
Subject: Re: KLive: Linux Kernel Live Usage Monitor
Message-ID: <20050830164054.GW8515@g5.random>
References: <20050830030959.GC8515@g5.random> <Pine.LNX.4.63.0508300954190.1984@cassini.linux4geeks.de> <20050830082901.GA25438@bitwizard.nl> <Pine.LNX.4.63.0508301044150.1984@cassini.linux4geeks.de> <20050830094058.GA29214@bitwizard.nl> <20050830151035.GO8515@g5.random> <1125419618.8276.30.camel@localhost.localdomain> <20050830161634.GR8515@g5.random> <1125420993.8276.36.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1125420993.8276.36.camel@localhost.localdomain>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2005 at 05:56:33PM +0100, Alan Cox wrote:
> I doubt there is anything needed that can't be done in sh and nc here.
> Catching boots can be done by adding one to a boot number and sending
> that as well. How does suspend to disk handle uptime - if the uptime
> stops then sending the uptime will deal with it.

I agree it's feasible.

> I'm happy to whack on some sh scripts to do the client side.

You're welcome, the client directory currently contains the tac file, we
can add more clients no problem ;).
