Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261427AbULICX7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261427AbULICX7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 21:23:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261440AbULICX7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 21:23:59 -0500
Received: from probity.mcc.ac.uk ([130.88.200.94]:34319 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP id S261427AbULICXz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 21:23:55 -0500
Date: Thu, 9 Dec 2004 02:23:55 +0000
From: John Levon <levon@movementarian.org>
To: Greg Banks <gnb@sgi.com>
Cc: Philippe Elie <phil.el@wanadoo.fr>, Akinobu Mita <amgta@yacht.ocn.ne.jp>,
       linux-kernel@vger.kernel.org
Subject: Re: [mm patch] oprofile: backtrace operation does not initialized
Message-ID: <20041209022355.GA50185@compsoc.man.ac.uk>
References: <200412081830.51607.amgta@yacht.ocn.ne.jp> <20041208160055.GA82465@compsoc.man.ac.uk> <20041208223156.GB4239@sgi.com> <20041208235623.GA563@zaniah> <20041209003906.GE4239@sgi.com> <20041209014622.GB48804@compsoc.man.ac.uk> <20041209015024.GG4239@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041209015024.GG4239@sgi.com>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Graham Coxon - Happiness in Magazines
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *1CcDyF-000Nb2-73*zoNg7YjjzBE*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 09, 2004 at 12:50:24PM +1100, Greg Banks wrote:

> Ok, how about this patch?

Fine by me

john

> Allow stack tracing to work when sampling on timer is forced
> using the timer=1 boot option.  Reported by Akinobu Mita.
