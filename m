Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751224AbWFEQSy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751224AbWFEQSy (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 12:18:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751219AbWFEQSx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 12:18:53 -0400
Received: from ns.suse.de ([195.135.220.2]:48262 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751210AbWFEQSw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 12:18:52 -0400
Date: Mon, 5 Jun 2006 09:16:10 -0700
From: Greg KH <greg@kroah.com>
To: Pavel Machek <pavel@suse.cz>, Arjan van de Ven <arjan@infradead.org>,
        Jirka Lenost Benc <jbenc@suse.cz>,
        kernel list <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
        pe1rxq@amsat.org
Subject: Re: move zd1201 where it belongs
Message-ID: <20060605161610.GA26259@kroah.com>
References: <20060605103952.GA1670@elf.ucw.cz> <1149506120.3111.52.camel@laptopd505.fenrus.org> <20060605113332.GB2132@elf.ucw.cz> <20060605141322.GB23350@tuxdriver.com> <20060605142912.GF2132@elf.ucw.cz> <20060605144722.GA6068@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060605144722.GA6068@tuxdriver.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 05, 2006 at 10:47:26AM -0400, John W. Linville wrote:
> On Mon, Jun 05, 2006 at 04:29:12PM +0200, Pavel Machek wrote:
> 
> > > Did you mean to only copy Jiri and LKML?
> > 
> > Yes, because this should go in as a git patch (so it is move, not
> > create new file), and I was hoping for Jiri to generate proper
> > git-patch :-).
> 
> Ah, I see.  Well, I can handle this just fine.

Ack from my side, feel free to move this to your section of the kernel
:)

thanks,

greg k-h
