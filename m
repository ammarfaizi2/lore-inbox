Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263399AbUJ2O5Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263399AbUJ2O5Y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 10:57:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263387AbUJ2OwC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 10:52:02 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:36232 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S263342AbUJ2OuX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 10:50:23 -0400
Date: Fri, 29 Oct 2004 16:50:22 +0200
From: Jan Kara <jack@suse.cz>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] Configurable Magic Sysrq
Message-ID: <20041029145022.GA31945@atrey.karlin.mff.cuni.cz>
References: <20041029093941.GA2237@atrey.karlin.mff.cuni.cz> <20041029024651.1ebadf82.akpm@osdl.org> <yw1xu0sdiwr2.fsf@inprovide.com> <20041029133527.GA25172@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.53.0410291632310.16820@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0410291632310.16820@yvahk01.tjqt.qr>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >> >>    I know about a few people who would like to use some functionality of
> >> >>  the Magic Sysrq but don't want to enable all the functions it provides.
> >> >
> >> > That's a new one.  Can you tell us more about why people want to do such a
> >> > thing?
> 
> Like me, I only need sysrq's S, U, B and sometimes K ;-)
> How much space does it take anyway for the other sysrqs?
> If it's below 8K (arbitrarily chosen limit) then I can live with "all sysrqs"
> being in.
  It's not about the kernel size but about allowing user to invoke just
some functions and not the other (see my other mail).

								Honza
-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
