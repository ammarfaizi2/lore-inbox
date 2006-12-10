Return-Path: <linux-kernel-owner+w=401wt.eu-S1762445AbWLJTSy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762445AbWLJTSy (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 14:18:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762520AbWLJTSy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 14:18:54 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:4772 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1762438AbWLJTSy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 14:18:54 -0500
Date: Sun, 10 Dec 2006 20:19:01 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Paul Mundt <lethal@linux-sh.org>,
       "Robert P. J. Day" <rpjday@mindspring.com>,
       Jeff Garzik <jeff@garzik.org>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: why are some of my patches being credited to other "authors"?
Message-ID: <20061210191901.GF10351@stusta.de>
References: <Pine.LNX.4.64.0612090515480.12992@localhost.localdomain> <457A9F3B.6020009@garzik.org> <Pine.LNX.4.64.0612090706500.13654@localhost.localdomain> <20061210050920.GA19828@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061210050920.GA19828@linux-sh.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 10, 2006 at 02:09:20PM +0900, Paul Mundt wrote:
>...
> trivial@kernel.org exists to handle the rest of the bits, where Adrian
> has a tendency to queue up many trivial and related patches at once, and
> sending out pull requests at a time where it will be less disruptive to
> the rest of development. You might be better off simply CC'ing trivial@
> on these patch submissions and routinely checking the trivial git tree to
> see whether they've been queued or not.
>...

Checking the tree won't help since it's only different from Linus' tree 
in the few hours between me asking Linus to pull and Linus actually 
pulling.

Patches to trivial@kernel.org simply go into a mail folder, and I'm 
going through this during the two week merge window.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

