Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264881AbUHJOLu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264881AbUHJOLu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 10:11:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264919AbUHJOLu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 10:11:50 -0400
Received: from mail.kroah.org ([69.55.234.183]:28395 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264881AbUHJOLs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 10:11:48 -0400
Date: Mon, 9 Aug 2004 17:21:37 -0700
From: Greg KH <greg@kroah.com>
To: Michael Buesch <mbuesch@freenet.de>
Cc: Eric Lammerts <eric@lammerts.org>,
       Albert Cahalan <albert@users.sourceforge.net>,
       Marc Ballarin <Ballarin.Marc@gmx.de>, albert@users.sourceforge.net,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: dynamic /dev security hole?
Message-ID: <20040810002137.GD7131@kroah.com>
References: <20040808162115.GA7597@kroah.com> <200408091854.27019.mbuesch@freenet.de> <Pine.LNX.4.58.0408091302010.9426@vivaldi.madbase.net> <200408091914.19412.mbuesch@freenet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408091914.19412.mbuesch@freenet.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 09, 2004 at 07:14:16PM +0200, Michael Buesch wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Quoting Eric Lammerts <eric@lammerts.org>:
> > Better not do it for symlinks.
> 
> Yes, you're right.

Thanks, I've applied this patch.

greg k-h
