Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261629AbUCKTtb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 14:49:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261687AbUCKTta
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 14:49:30 -0500
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:28946 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S261629AbUCKTtZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 14:49:25 -0500
Date: Thu, 11 Mar 2004 20:49:25 +0100
From: Tomasz Torcz <zdzichu@irc.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: LKM rootkits in 2.6.x
Message-ID: <20040311194925.GA31825@irc.pl>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0403111124020.27770-100000@linuxbox.co.uk> <20040311184835.GA21330@redhat.com> <1079032587.7517.1.camel@leto.cs.pocnet.net> <yw1xekrz41ui.fsf@kth.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yw1xekrz41ui.fsf@kth.se>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2004 at 08:31:49PM +0100, M?ns Rullg?rd wrote:
> Christophe Saout <christophe@saout.de> writes:
> > Ugh... this sounds ugly. This should be forbidden. I mean, what are
> > things like EXPORT_SYMBOL_GPL for if drivers are allowed to patch
> > whatever they want?
> 
> Who is to stop them?  When running in kernel mode you are god.

 Uhm, Next Generation Secure Computing Base? Running in ring -1. ;)

Sorry, I couldn't resist ;)
-- 
Tomasz Torcz                Only gods can safely risk perfection,     
zdzichu@irc.-nie.spam-.pl     it's a dangerous thing for a man.  -- Alia

