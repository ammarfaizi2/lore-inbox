Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263335AbVGANU6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263335AbVGANU6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 09:20:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263336AbVGANU6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 09:20:58 -0400
Received: from smtpout4.uol.com.br ([200.221.4.195]:52733 "EHLO
	smtp.uol.com.br") by vger.kernel.org with ESMTP id S263335AbVGANU4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 09:20:56 -0400
Date: Fri, 1 Jul 2005 10:19:50 -0300
From: =?iso-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
To: linux-kernel@vger.kernel.org
Subject: Re: XFS corruption during power-blackout
Message-ID: <20050701131950.GA15180@ime.usp.br>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20050629001847.GB850@frodo> <200506290453.HAA14576@raad.intranet> <556815.441dd7d1ebc32b4a80e049e0ddca5d18e872c6e8a722b2aefa7525e9504533049d801014.ANY@taniwha.stupidest.org> <42C4FC14.7070402@slaphack.com> <20050701092412.GD2243@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050701092412.GD2243@suse.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 01 2005, Jens Axboe wrote:
> On Fri, Jul 01 2005, David Masover wrote:
> > Not always possible.  Some disks lie and leave caching on anyway.
> 
> And the same (and others) disks will not honor a flush anyways.
> Moral of that story - avoid bad hardware.

But how does the end-user know what hardware is "good hardware"? Which
vendors don't lie (or, at least, lie less than others) regarding HDs?


Thanks, Rogério Brito.

-- 
Rogério Brito : rbrito@ime.usp.br : http://www.ime.usp.br/~rbrito
Homepage of the algorithms package : http://algorithms.berlios.de
Homepage on freshmeat:  http://freshmeat.net/projects/algorithms/
