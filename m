Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261214AbVEOUFV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261214AbVEOUFV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 May 2005 16:05:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261215AbVEOUFV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 May 2005 16:05:21 -0400
Received: from w241.dkm.cz ([62.24.88.241]:17848 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261214AbVEOUFP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 May 2005 16:05:15 -0400
Date: Sun, 15 May 2005 22:05:14 +0200
From: Petr Baudis <pasky@ucw.cz>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: James Ketrenos <jketreno@linux.intel.com>, Netdev <netdev@oss.sgi.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org
Subject: Re: git repository for net drivers available
Message-ID: <20050515200514.GA31414@pasky.ji.cz>
References: <42841A3F.7020909@pobox.com> <4284C54E.3060907@linux.intel.com> <4284C7DA.1020707@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4284C7DA.1020707@pobox.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear diary, on Fri, May 13, 2005 at 05:29:30PM CEST, I got a letter
where Jeff Garzik <jgarzik@pobox.com> told me that...
> Looks like cogito is using $repo/heads/$branch, whereas my git repo is 
> using $repo/branches/$branch.

Would it be a big problem to use refs/heads/$branch? That's the
currently commonly agreed convention about location for storing branch
heads, not just some weird Cogito-specific invention. And it'd be very
nice to have those locations consistent across git repositories.

Thanks,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
