Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262959AbSKRQ6c>; Mon, 18 Nov 2002 11:58:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263291AbSKRQ6c>; Mon, 18 Nov 2002 11:58:32 -0500
Received: from poup.poupinou.org ([195.101.94.96]:5665 "EHLO poup.poupinou.org")
	by vger.kernel.org with ESMTP id <S262959AbSKRQ5u>;
	Mon, 18 Nov 2002 11:57:50 -0500
Date: Mon, 18 Nov 2002 18:04:47 +0100
To: Vergoz Michael <mvergoz@sysdoor.com>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 8139too.c patch for kernel 2.4.19
Message-ID: <20021118170447.GB27595@poup.poupinou.org>
References: <028901c28ead$10dfbd20$76405b51@romain> <3DD89813.9050608@pobox.com> <003b01c28edf$9e2b1530$76405b51@romain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <003b01c28edf$9e2b1530$76405b51@romain>
User-Agent: Mutt/1.4i
From: Ducrot Bruno <poup@poupinou.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 18, 2002 at 09:50:50AM +0100, Vergoz Michael wrote:
> Hi Jeff,
> 
> What i see is the current driver _doesn't_ work on my realtek 8139C.
> With this one it work fine.

The question was (as I understand the changes you made and the
answer from Jeff) : did your card work with 8139cp or not?

If not, you have to modify 8139cp, which is the right place for C+ support.

-- 
Ducrot Bruno
http://www.poupinou.org        Page profaissionelle
http://toto.tu-me-saoules.com  Haume page
