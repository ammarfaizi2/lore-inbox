Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267152AbTAFVmQ>; Mon, 6 Jan 2003 16:42:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267166AbTAFVmP>; Mon, 6 Jan 2003 16:42:15 -0500
Received: from phoenix.infradead.org ([195.224.96.167]:28173 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S267152AbTAFVmO>; Mon, 6 Jan 2003 16:42:14 -0500
Date: Mon, 6 Jan 2003 21:50:49 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Andrew Rodland <arodland@noln.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: fbcon breakage?
In-Reply-To: <200301012327.18244.arodland@noln.com>
Message-ID: <Pine.LNX.4.44.0301062150130.31831-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I'm using a Dell Latitude CPi A laptop, with a Neomagic 2200 graphics chip in 
> it.
> Since earlier today, I can't get it to work with neofb; I get a really nasty 
> oops early in the boot, right after neofb initialized.
>  I changed more than a few things today, but I changed everything back, 
> around, and in circles, and it still seems to come down to neofb.
> 
> Anyway, I manually copied down the oops and ran it through ksymoops.
> Output follows.

Fixed in the latest tree. Will be pushing new fixes soon.

