Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751866AbWD2K3b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751866AbWD2K3b (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Apr 2006 06:29:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751864AbWD2K3b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Apr 2006 06:29:31 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:25286 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1750704AbWD2K3a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Apr 2006 06:29:30 -0400
Subject: Re: IP1000 gigabit nic driver
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: "David =?ISO-8859-1?Q?G=F3mez?=" <david@pleyades.net>
Cc: David Vrabel <dvrabel@cantab.net>, Francois Romieu <romieu@fr.zoreil.com>,
       Linux-kernel <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0604281458110.19801@sbz-30.cs.Helsinki.FI>
References: <20060427142939.GA31473@fargo>
	 <20060427185627.GA30871@electric-eye.fr.zoreil.com>
	 <445144FF.4070703@cantab.net> <20060428075725.GA18957@fargo>
	 <84144f020604280358ie9990c7h399f4a5588e575f8@mail.gmail.com>
	 <20060428113755.GA7419@fargo>
	 <Pine.LNX.4.58.0604281458110.19801@sbz-30.cs.Helsinki.FI>
Content-Type: text/plain; charset=ISO-8859-15
Date: Sat, 29 Apr 2006 13:29:26 +0300
Message-Id: <1146306567.1642.3.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Apr 2006, David Gómezz wrote:
> > Ok, i could take care of that, and it's a good way of getting my hands
> > dirty with kernel programming ;). David, if it's ok to you i'll do the
> > cleanup thing.

On Fri, 2006-04-28 at 14:59 +0300, Pekka J Enberg wrote:
> Here are some suggestions for coding style cleanups:

[snip]

I ended up doing most of them myself [1]. Sorry :-) Are the datasheets
public by the way?

			Pekka

  1. http://www.cs.helsinki.fi/u/penberg/linux/ip1000-driver.patch

