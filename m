Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131574AbRAUSXy>; Sun, 21 Jan 2001 13:23:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131579AbRAUSXp>; Sun, 21 Jan 2001 13:23:45 -0500
Received: from ferret.phonewave.net ([208.138.51.183]:50194 "EHLO
	tarot.mentasm.org") by vger.kernel.org with ESMTP
	id <S131574AbRAUSXa>; Sun, 21 Jan 2001 13:23:30 -0500
Date: Sun, 21 Jan 2001 10:23:15 -0800
To: egger@suse.de
Cc: jgarzik@mandrakesoft.com, burnus@gmx.de, linux-kernel@vger.kernel.org
Subject: Re: Ethernet drivers: SiS 900, Netgear FA311
Message-ID: <20010121102315.A16586@ferret.phonewave.net>
In-Reply-To: <3A6A2D8D.D55655D5@mandrakesoft.com> <20010121134822.A46D4735B@Nicole.muc.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010121134822.A46D4735B@Nicole.muc.suse.de>; from egger@suse.de on Sun, Jan 21, 2001 at 01:54:34PM +0100
From: idalton@ferret.phonewave.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 21, 2001 at 01:54:34PM +0100, egger@suse.de wrote:
> On 20 Jan, Jeff Garzik wrote:
> 
> > Not true, see natsemi.c (in 2.4.x at least).
> 
>  Correct, and the cards really work with it.

natsemi did not work with 2.2.17 on a remote system I do work on, but
did work with the 2.4.0-included driver. Wonder if it'll be making it
into 2.2.x soon..

-- Ferret
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
